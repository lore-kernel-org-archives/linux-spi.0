From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v1 1/1] spi: npcm: fix uninitialized 'val' warning in
 receive function
Date: Sun, 18 Nov 2018 13:38:05 -0800
Message-ID: <CAOesGMjUJ1+qmbPWcVFm1F_F0fcdg-54YY6o4iK=PYWoAuEczA@mail.gmail.com>
References: <20181118123504.83082-1-tmaimon77@gmail.com> <20181118123504.83082-2-tmaimon77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, Joel Stanley <joel@jms.id.au>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118123504.83082-2-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Nov 18, 2018 at 4:36 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Fix uninitialized 'val' warning receive function, send function
> has been modify to be aligned with the receive function.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/spi/spi-npcm-pspi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
> index 6dae91091143..f75df49ab84e 100644
> --- a/drivers/spi/spi-npcm-pspi.c
> +++ b/drivers/spi/spi-npcm-pspi.c
> @@ -199,11 +199,11 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
>         wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
>         priv->tx_bytes -= wsize;
>
> -       if (priv->tx_buf) {
> -               if (wsize == 1)
> -                       iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
> +       if (priv->tx_buf && wsize) {

In general, doing an early:
        if (!condition)
                return;

is a pattern we prefer in the kernel. Setting up the assumptions at
the beginning of the function makes it easier to follow the code flow,
and saves a level of indentation.

It's a matter of taste though, and this function has only one level.
So, either way is OK. Just mentioning it.

>                 if (wsize == 2)
>                         iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
> +               else
> +                       iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);

I think this is broken? If wsize is something else than 1 or 2, you'll
do a one-byte write but advance the buffer pointer with a different
amount.

It'll be fairly tricky to debug if this ever happens (it shouldn't,
but still). This is why I added a WARN_ON_ONCE() in my patch instead.


-Olof
