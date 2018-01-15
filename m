From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/3] dt-bindings: spi: Add DT bindings for Synquacer
Date: Mon, 15 Jan 2018 09:15:23 -0600
Message-ID: <CAL_JsqKM2OhdhFZfd_fhBkYiFE9Fdr38Xn7TKorwJo_-+f9xUg@mail.gmail.com>
References: <1516021530-19236-1-git-send-email-jassisinghbrar@gmail.com> <1516021559-19327-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Masami Hiramatsu <masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516021559-19327-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 15, 2018 at 7:05 AM,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This patch adds documentation for Device-Tree bindings for the
> Socionext Synquacer spi driver.
>
> Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-synquacer.txt      | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-synquacer.txt b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
> new file mode 100644
> index 0000000..d013cfd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-synquacer.txt
> @@ -0,0 +1,24 @@
> +* Socionext Synquacer HS-SPI bindings
> +
> +Required Properties:
> +- compatible: should be "socionext,synquacer-spi"
> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- clocks: Must contain an entry for rate source clock(s).
> +- clock-names: Shall be "iHCLK" or "iPCLK". iHCLK is preferred over iPCLK

Huh? The clock binding should reflect all clocks connected to a block,
not a selection of which one you want to use.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
