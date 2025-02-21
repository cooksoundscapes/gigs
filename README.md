# Songs MonoRepo

Right now, every project should have a copy of  `[patch_handler]`;
`instruments.md` explains how to use `instruments.lua` file to automate param control via `patch_handler`;
  
each project can have a `/pages` directory to keep UIs.
For changes to reflect, `~/discipline/precompiler/run.sh` should be called manually. It sweeps this entire directory for .xmls inside /pages and generates a .cpp file in `~/discipline/graphics/pages`. Additionally, `~/discipline/graphics/run.sh` should be reloaded.
  
Projects that shouldn't be uploaded just add in .gitignore