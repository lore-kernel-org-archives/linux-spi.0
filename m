From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: [PATCH] spi-imx: imx6q add single burst transfer support
Date: Wed, 1 Jun 2016 13:06:29 +0800
Message-ID: <574E6D55.9080609@gtsys.com.hk>
References: <1464756628-25463-1-git-send-email-chris.ruehl@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464756628-25463-1-git-send-email-chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, June 01, 2016 12:50 PM, Chris Ruehl wrote:
> The patch add support for single burst transfer where chipselect will
> hold active until transfer completes with a limit to 2^7 words transferred.
> The single-burst-mode need set the burstlength in ECSPI_CONREG.BURST_LENGTH
> and clear the ecspi channel related ss_ctl flag in ECSPI_CONFIGREG.SS_CTL.
>
> The single-burst-mode is disabled by default. The activation from spidev
> is implemented by set bit0 of the xfer.speed_hz, which don't break anything
> in the mx51_ecspi_clkdiv() function.
>
> xfer[0].speed_hz = 2000000 | 0x1; /* enable single burst mode with 1hz */
>
> There is a bug in the SDMA firmware (referenced as TKT238285 or ERR008517)
> which breaks the transmission with a odd numbers of bytes.
> Its turns out, that its safe to use with slaves in half duplex mode where
> always an even number of bytes is required.
>
> function added:
> spi_imx_buf_tx_sb()  - singleburst transmit
> spi_imx_buf_rx_sb()  - singleburst receive
>
> stucts modified:
> spi_imx_config - add len ; add single_burst_mode:1
> spi_imx_data   - add rxcount; add bits_per_word
>
> Signed-off-by: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>

User Space program - sensor MPL115A1 in sb-mode
-----------------
16 	>> "88008a008c008e009000920094009600"
16 	<< "003d007100b500c300c2004100350010"
2 	>> "2400"
2 	<< "0000"
8 	>> "8000820084008600"
8 	<< "005f0040006d0040"
Pres ADC: 381
Temp ADC: 437
a0: 1966.12
b1: -2.31995
b2: -0.964783
c12: 0.000809669
Pcomp: 795.423
Pressure:  100.54 kPa


Kernel debug
------------
[ 1065.586066] spi_imx 200c000.ecspi: Single Burst reg:0x00000003 cfg:0x00000000 
ctrl:0x07f0e1f1
[ 1065.586088] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 16 ptr:0x008a0088
[ 1065.586105] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 12 ptr:0x008e008c
[ 1065.586119] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 8 ptr:0x00920090
[ 1065.586133] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 4 ptr:0x00960094
[ 1065.586209] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 16 val:0x003d0071
[ 1065.586227] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 12 val:0x00b500c3
[ 1065.586242] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 8 val:0x00c20041
[ 1065.586256] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 4 val:0x00350010

[ 1065.593173] spi_imx 200c000.ecspi: mx51_ecspi_clkdiv: fin: 60000000, fspi: 
2000001, post: 1, pre: 14
[ 1065.593195] spi_imx 200c000.ecspi: Single Burst reg:0x00000000 cfg:0x00000000 
ctrl:0x00f0e1f1
[ 1065.593216] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 2 ptr:0x008a0024
[ 1065.593248] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 2 val:0x00000000

[ 1065.604517] spi_imx 200c000.ecspi: mx51_ecspi_clkdiv: fin: 60000000, fspi: 
2000001, post: 1, pre: 14
[ 1065.604539] spi_imx 200c000.ecspi: Single Burst reg:0x00000001 cfg:0x00000000 
ctrl:0x03f0e1f1
[ 1065.604559] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 8 ptr:0x00820080
[ 1065.604575] spi_imx 200c000.ecspi: spi_imx_buf_tx_sb: txcount: 4 ptr:0x00860084
[ 1065.604618] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 8 val:0x005f0040
[ 1065.604633] spi_imx 200c000.ecspi: spi_imx_buf_rx_sb: rxcount: 4 val:0x006c0080



-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: http://www.gtsys.com.hk/email/classified.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
