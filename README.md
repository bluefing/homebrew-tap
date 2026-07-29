# homebrew-tap

A personal [Homebrew](https://brew.sh) tap.

```bash
brew tap bluefing/tap
```

Then install any formula below by its fully-qualified name (`bluefing/tap/<name>`).

## Formulae

### bluefin-vm

Download, import, and run a [Bluefin](https://projectbluefin.io) VM on Apple
Silicon — project at <https://github.com/bluefing/bluefin-vm>.

`bluefin-vm` shells out to `tart` (the VM runtime), which lives in OpenAI's own
third-party tap, so first-time setup trusts two taps — tart's, then this one:

```bash
brew tap openai/tools
brew trust openai/tools
brew install bluefing/tap/bluefin-vm
bluefin-vm up
```

#### Trust

Homebrew won't load formula code from an unofficial tap until you trust it, and
it does **not** auto-trust a dependency's tap. The fully-qualified
`brew install` self-trusts `bluefin-vm`, but its `tart` dependency — and tart's
own `softnet` dependency — come from `openai/tools`, so that tap needs trusting
too (trusting `tart` alone doesn't cover `softnet`).

`brew trust openai/tools` covers both in one go; alternatively for per-item
trust, run `brew trust --formula openai/tools/tart` then the same for
`openai/tools/softnet`.

See Homebrew [Tap Trust](https://docs.brew.sh/Tap-Trust).

#### Brewfile

Each unofficial-tap entry needs `trusted: true`, or `brew bundle` fails the
trust check:

```ruby
tap "openai/tools", trusted: true
brew "bluefing/tap/bluefin-vm", trusted: true
```
