# Everything Pasadena — Deploy Guide

This folder is a ready-to-push git repo containing the site preview as
`index.html`. Follow the steps below to get it live so you can share a link.

## Step 1 — Push this to GitHub

You already have a GitHub account, so:

1. Go to https://github.com/new and create a new repository (e.g. named
   `everything-pasadena`). Leave it empty — don't add a README, .gitignore,
   or license.
2. On your own computer (or wherever you have `git` and your GitHub login
   set up), download this `deploy` folder and run:

   ```
   cd deploy
   git remote add origin https://github.com/YOUR_GITHUB_USERNAME/everything-pasadena.git
   git branch -M main
   git push -u origin main
   ```

   Git will prompt you to sign in the first time (browser popup or a
   personal access token — GitHub will walk you through it).

   **No terminal? Easier option:** on your new repo's GitHub page, click
   "Add file" → "Upload files", and drag in `index.html` directly. That's
   the whole deploy for GitHub's side — no git commands needed.

## Step 2 — (Optional but fastest) See it live immediately with GitHub Pages

Since this is just a static HTML file, GitHub can host it for free, no
Vultr required:

1. In your repo, go to Settings → Pages.
2. Under "Build and deployment", set Source to "Deploy from a branch",
   branch `main`, folder `/ (root)`. Save.
3. Wait about a minute — GitHub will give you a URL like
   `https://YOUR_GITHUB_USERNAME.github.io/everything-pasadena/`.

That link is shareable immediately. If you just want people to *see* the
design, you can stop here. Continue below if you specifically want it on
your own Vultr server (e.g. because you plan to run the full WordPress
site there later).

## Step 3 — Deploy to Vultr

1. Sign up at https://www.vultr.com (I can't create this account for you
   — it needs your own billing info).
2. Once logged in, go to **Products → Startup Scripts → Add Script**.
   Paste in the contents of `vultr-startup-script.sh` (in this folder) —
   but first edit the line that says
   `YOUR_GITHUB_USERNAME/YOUR_REPO_NAME` to match the repo you created in
   Step 1.
3. Go to **Products → Deploy New Server**:
   - Choose "Cloud Compute" (the cheapest shared vCPU plan is plenty —
     around $5-6/month for a preview site).
   - Choose an Ubuntu 22.04 or 24.04 image.
   - Under "Startup Script", select the script you just saved.
   - Deploy.
4. Wait a couple minutes for the server to boot and the script to run,
   then visit the server's IP address (shown on its Vultr dashboard page)
   in a browser — the site will be live there.

### Updating the site later

Whenever you push new changes to the `main` branch on GitHub, the Vultr
server won't pick them up automatically — SSH into it and run:

```
cd /var/www/html && git pull
```

(Vultr's dashboard has a "View Console" button that gives you a
browser-based terminal if you don't have an SSH client handy.)

### Optional — a real domain name

Once the server is live at its IP, you can point a domain you own at it
by adding an A record to that IP in your domain's DNS settings, then
(optionally) setting up free HTTPS with Let's Encrypt:

```
apt-get install -y certbot python3-certbot-nginx
certbot --nginx -d yourdomain.com
```
