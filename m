From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/11] pinctrl: sh-pfc: r8a7791: fix msiof groups to
 follow GROUP
Date: Tue, 3 Dec 2013 11:08:14 +0100
Message-ID: <CACRpkdYyLS3gy53GOJhEwYXh4uW_Uxa5PLF1E45OhWvUiMfYpA@mail.gmail.com>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org> wrote:

> From: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
>
> SH_PFC_PIN_GROUP(), pins[], mux[], defines
>  clk, sync, ss1, ss2, rx, tx
> But, msiof?_groups[] defines
>  clk, ctrl, data
>
> Fix msiof[012]_groups members to be consistent to PIN_GROUP.
>
> Signed-off-by: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>

This looks all right to me. Laurent is merging PFC patches for this
kernel cycle, please make sure you include him on subsequent
postings. Once Laurent has a finished series I'll pull it into
the pinctrl tree.

I think the device tree changes part of this series can go directly
to Simon though?

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
