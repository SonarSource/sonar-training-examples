/** @type {import('next').NextConfig} */

const instrumentTheCode = 'INSTRUMENT_CODE' in process.env;

const nextConfig = {
  reactStrictMode: true,
  ...(instrumentTheCode ? {
    experimental: {
      swcPlugins: [
        [
          "swc-plugin-coverage-instrument", {}
        ]
      ]
    }
  } : {})
}

module.exports = nextConfig
