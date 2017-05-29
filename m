From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH linux-next v3 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Mon, 29 May 2017 08:07:42 -0300
Message-ID: <CAOMZO5D4O38M3ZQYxcT2w+oW=HBuk2WPMN7Ue4Va_gz3zbKZ=Q@mail.gmail.com>
References: <1495774962-2981-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495774962-2981-1-git-send-email-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jiada,

On Fri, May 26, 2017 at 2:02 AM,  <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:
> From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>
> previously burst length (BURST_LENGTH) is always set to equal
> to bits_per_word, causes a 10us gap between each word in
> transfer, which significantly affects performance.
>
> This patch uses 32 bits transfer to simulate lower bits transfer,
> and adjusts burst length runtimely to use biggeest burst length
> as possible to reduce the gaps in transfer for PIO mode.

Just curious: what is the performance gain you observe with this patch?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
