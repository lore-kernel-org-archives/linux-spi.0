From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Tue, 17 Mar 2015 10:28:22 +0100
Message-ID: <CAMuHMdX_PrPLh1vyzpd+P=ehCNCPmfqkFVjt4RjjBjT9gOiqFg@mail.gmail.com>
References: <1426430192-3271-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426430192-3271-1-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kaneko-san, Kataoka-san,

On Sun, Mar 15, 2015 at 3:36 PM, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.

"Address 0xE7xx can be accesses only from DMA." was indeed removed.
However, "Note: Address H'E6xx can be accessed only by CPU." is still
there in the latest version of the R-Car Gen2 manual I have (v1.01).
Presumably all of this was copied from another SoC (see below)?

MSIOF DMA seems to work fine on my Koelsch (R-Car M2-W ES1.0) with this patch
(and the DTS changes) applied, though.

> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>
> Hi Geert-san,
>
> I have also found patches to address this problem in DTS files
> which seems to be a good way to handle this problem. I plan to send
> them separately. I'm unsure if this driver change is also appropriate.

If there really exist no SoCs where the DMA engine has to access a different
register set than the CPU, then it can be removed from the driver, and from
the binding docs in Documentation/devicetree/bindings/spi/sh-msiof.txt.

However, according to the manuals, SH-Mobile AG5 (sh73a0), R-Mobile APE6
(r8a73a4), and R-Mobile A1 (r8a7740) also have MSIOF blocks with two register
banks?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
