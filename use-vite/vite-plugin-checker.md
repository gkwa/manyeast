**Vite Plugin Checker Setup**

1. **Install the plugin:**

   ```bash
   npm install --save-dev vite-plugin-checker
   ```

2. **Add to vite.config.js:**

   ```js
   import { defineConfig } from 'vite';
   import checker from 'vite-plugin-checker';

   export default defineConfig({
     plugins: [
       checker({
         typescript: true,
       }),
     ],
   });
   ```

3. **Start your dev server.** Type errors now appear in the browser overlay and terminal.

4. **Build process includes type checking.** No separate script needed - it's built into Vite.

5. **Errors block the build.** Fix TypeScript issues or the build fails.

The plugin runs type checking alongside Vite's normal operations. You get real-time type error feedback during development and guaranteed type safety in production builds.
