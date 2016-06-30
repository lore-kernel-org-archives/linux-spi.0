From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/4] spi: Document option to wake a device by toggling CS
Date: Thu, 30 Jun 2016 09:12:09 +0200
Message-ID: <CAMuHMdXCeFMXPczi3b=GpUEzUJiz0+sK_299GY8o-iYgP8G9iA@mail.gmail.com>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org> <1467258867-117727-2-git-send-email-apronin@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: apronin@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467258867-117727-2-git-send-email-apronin@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

CC devicetree

On Thu, Jun 30, 2016 at 5:54 AM,  <apronin@chromium.org> wrote:
> From: Andrey Pronin <apronin@chromium.org>
>
> Some SPI devices may go to sleep after a period of inactivity
> on SPI. For such devices, if enough time has passed since the
> last SPI transaction, toggle CS and wait for the device to
> start before communicating with it.
>
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 42d5954..1b7ffd4 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -63,6 +63,13 @@ contain the following properties.
>                        used for MISO. Defaults to 1 if not present.
>  - spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
>  - spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
> +- cs-wake-after-sleep - (optional) Device may go to sleep after a period
> +               of SPI inactivity. If this flag is set, toggle CS and
> +               wait for it to wake before communicating to it.
> +- cs-sleep-delay  - (optional) Delay after which the device may go to
> +               sleep if there was no SPI activity (msec).
> +- cs-wake-duration - (optional) Time it takes the device to wake up after
> +               toggling CS if it went to sleep (msec).
>
>  Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>  It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
> --
> 2.6.6
