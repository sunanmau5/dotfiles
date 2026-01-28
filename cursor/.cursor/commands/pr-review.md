You are helping me review a pull request. Follow this workflow:

### Step 1: Find Relevant PRs

Find open PRs where I am assigned, requested as a reviewer, or have already submitted a review:

```bash
gh pr list \
  --search "is:open (review-requested:@me OR reviewed-by:@me OR assignee:@me)" \
  --limit 10 \
  --json number,title,author,reviewRequests,assignees,createdAt \
  --jq '.[] | {number, title, author: .author.login, reviewers: [.reviewRequests[]?.login], assignees: [.assignees[]?.login], created: .createdAt}'
```

If there are multiple PRs, ask which one I want to review. Present the results to me as a numbered list for me to choose from. If there's only one, confirm before proceeding.

### Step 2: Check Out and Examine the PR

Once I confirm the PR:

1. Check out the PR locally: `gh pr checkout <PR_NUMBER>`
2. Get PR details: `gh pr view <PR_NUMBER>`
3. Get the full diff against the base branch: `gh pr diff <PR_NUMBER>`
4. Check for existing review comments: `gh api repos/{owner}/{repo}/pulls/{pr_number}/comments`

### Step 3: Analyze the Changes

Examine the diff and provide:

**High-Level Summary**

- What is the overall purpose of this PR?
- New APIs introduced (endpoints, functions, methods)
- New or modified data structures (types, interfaces, schemas)
- New dependencies or libraries added
- Architectural or design pattern changes
- Configuration changes
- Database migrations or schema changes
- Any breaking changes

**Dependency Check**

- For any new dependencies: check if they are actively maintained
- Flag archived, deprecated, or unmaintained libraries
- Look for existing libraries in the codebase that could be used instead (check imports across the codebase)

**Impact Assessment**

- How does this affect existing code?
- What areas of the codebase will need to be aware of these changes?
- Are there documentation implications?

### Step 4: Review Focus Areas

Provide a numbered list of files or directories to review, in logical order (foundational changes first, then core logic, then usages, then tests). For each item, briefly note what to focus on:

- API or DB schema design considerations, if any
- Complex logic that needs careful examination
- Potential edge cases or error handling gaps
- Performance considerations
- Security implications
- Test coverage gaps
- Code style or consistency issues

### Step 5: Suggested Comments

Prepare a list of suggested review comments. For each comment:

- Keep it short and to the point
- Use a friendly, suggestion-based tone (e.g., "Consider...", "Might be worth...", "Nit: ...")
- Only be strongly opinionated if there's an obvious bug or issue
- Include the file path and line number
- **Verify line numbers** by reading the actual file content before suggesting

Format each suggestion as:

```
File: <path>
Line: <number>
Comment: <your suggestion>
```

### Step 6: Prepare gh CLI Commands

Generate ready-to-run commands.

**API note:** The GitHub "Create a review comment" endpoint does **not** accept `pull_request_review_id`. Add comments via **Create a review comment** (one request per comment) using `body`, `commit_id`, `path`, `line`, and `side`. Then submit your review. Do not send `pull_request_review_id`—it is not permitted and will return 422.

1. Get the commit SHA and set repo (replace `{owner}/{repo}` with e.g. `hallomarta/partner-app`):

   ```bash
   COMMIT_SHA=$(gh pr view <PR_NUMBER> --json headRefOid -q .headRefOid)
   ```

2. Add each line comment (one call per comment). Use **Create a review comment** — do **not** pass `pull_request_review_id`:

   ```bash
   gh api repos/{owner}/{repo}/pulls/{pr_number}/comments -X POST \
     -f body="<comment>" \
     -f commit_id="$COMMIT_SHA" \
     -f path="<file_path>" \
     -F line=<line_number> \
     -f side="RIGHT"
   ```

   Use `-F line=` (capital F) so the line number is sent as a number. For **multi-line comments**, add `-F start_line=<first_line>` and `-f start_side="RIGHT"` (and `-F line=<last_line>` is the end line).

3. **If you have an existing pending review** and want to submit it (e.g. after adding comments in the GitHub UI):

   ```bash
   # Find your pending review id
   ME=$(gh api user -q .login)
   gh api repos/{owner}/{repo}/pulls/{pr_number}/reviews --jq ".[] | select(.state==\"PENDING\" and .user.login==\"$ME\") | .id" -q .

   # Submit it (use the id from above)
   gh api repos/{owner}/{repo}/pulls/{pr_number}/reviews/{review_id} -X PUT \
     -f event="APPROVE" -f body="Short summary here."
   ```

   You cannot attach new comments to that pending review via the API (create-comment does not accept `pull_request_review_id`). To add more feedback, add comments with step 2 and then submit a new approval.

4. **After all line comments are added**, submit the review:

   ```bash
   gh pr review <PR_NUMBER> --approve --body "Short summary here."
   ```

   Keep the review body short (1-2 sentences). The detailed feedback is in the line comments.

5. Reply to an existing comment (if needed). Check [GitHub’s Pulls API](https://docs.github.com/en/rest/pulls/comments) for the correct endpoint; it may be create-comment with `in_reply_to` or a dedicated replies endpoint.

### Output Format

Present your findings in sections, then wait for my feedback. I will:

- Ask you to modify suggestions
- Tell you which comments to keep/remove
- Request changes to the review approach

Do NOT submit any reviews or comments until I explicitly approve the plan.
