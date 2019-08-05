From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v16 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 5 Aug 2019 10:00:57 +0800
Message-ID: <OFEFAD46C0.5BE85077-ON4825844D.000AB143-4825844D.000B12C8@mxic.com.tw>
References: <1564539258-16313-1-git-send-email-masonccyang@mxic.com.tw> <1564539258-16313-2-git-send-email-masonccyang@mxic.com.tw> <3d01957a-7318-274f-f3d5-6cd00850511b@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: broonie@kernel.org, devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, robh+dt@kernel.org
To: "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d01957a-7318-274f-f3d5-6cd00850511b@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Sergei, 

> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
> > diff --git a/drivers/spi/spi-renesas-rpc.c 
b/drivers/spi/spi-renesas-rpc.c
> > new file mode 100644
> > index 0000000..648d14e
> > --- /dev/null
> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,754 @@
> [...]
> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> > +{
> > +   //
> > +   // NOTE: The 0x260 are undocumented bits, but they must be set.
> > +   //    RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> > +   //    0x0 : the delay is biggest,
> > +   //    0x1 : the delay is 2nd biggest,
> > +   //    On H3 ES1.x, the value should be 0, while on others,
> > +   //    the value should be 6.
> > +   //
> > +   regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> > +              RPC_PHYCNT_STRTIM(6) | 0x260);
> > +
> > +   //
> > +   // NOTE: The 0x1511144 are undocumented bits, but they must be set
> > +   //       for RPC_PHYOFFSET1.
> > +   //    The 0x31 are undocumented bits, but they must be set
> > +   //    for RPC_PHYOFFSET2.
> > +   //
> > +   regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) 
|
> > +           0x1511144);
> > +   regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> > +           RPC_PHYOFFSET2_OCTTMG(4));
> > +   regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> > +           RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> > +   regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE 
|
> > +           RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> > +           RPC_CMNCR_BSZ(0));
> > +}
> [...]
> > +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> > +            const void *tx_buf, void *rx_buf)
> > +{
> [...]
> > +err_out:
> > +   return reset_control_reset(rpc->rstc);
> 
>    Don't toy need to call rpc_spi_hw_init(( here? The reset would spoil
> the PHY/etc register setup otherwise...

ummm, will fix to
-------------------------------------->
ret = reset_control_reset(rpc->rstc);
rpc_spi_hw_init(rpc);
return ret;
--------------------------------------<
thanks for your review.

> 
> [...]
> 
> MBR, Sergei

best regards,
Mason

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================
