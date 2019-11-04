From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Mon, 4 Nov 2019 19:24:06 +0000
Message-ID: <20191104192406.GH5238@sirena.co.uk>
References: <1572886297-45400-1-git-send-email-john.garry@huawei.com>
 <1572886297-45400-3-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Cc: marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com
To: John Garry <john.garry@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1572886297-45400-3-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2019 at 12:51:36AM +0800, John Garry wrote:

> Only ACPI firmware is supported.

There's no ACPI dependency though?  If the driver only works with ACPI
I'd expect to see one with an || COMPILE_TEST like the architecture
dependency.

> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HiSilicon SPI NOR V3XX Flash Controller Driver for hi16xx chipsets
> + *

Please make the entire comment a C++ one for neatness.

> + * Copyright (c) 2019 HiSilicon Technologies Co., Ltd.
> + * Author: John Garry <john.garry@huawei.com>
> + */
> +//#define DEBUG 1

Please remove this.

> +#define GLOBAL_CFG (0x100)
> +
> +#define BUS_CFG1 (0x200)
> +#define BUS_CFG2 (0x204)
> +#define BUS_FLASH_SIZE (0x210)
> +
> +#define VERSION (0x1f8)

These could use some namespacing, especially the last one - it seems
quite likely there'll be some collisions at some point.

> +#define HISI_SFC_V3XX_WAIT_TIMEOUT_US		1000000
> +#define HISI_SFC_V3XX_WAIT_POLL_INTERVAL_US	10

Plus if we've got these long prefixes here it'd be good to be
consistent.

> +	if (IS_ALIGNED((uintptr_t)to, 4)) {
> +		int words = len / 4;
> +
> +		__ioread32_copy(to, host->regbase + CMD_DATABUF(0), words);
> +
> +		len -= words * 4;
> +		if (len) {
> +			u32 val;
> +
> +			val = __raw_readl(host->regbase + CMD_DATABUF(words));
> +
> +			to += words * 4;
> +			for (i = 0; i < len; i++, val >>= 8, to++)
> +				*to = (u8)val;
> +		}
> +	} else {
> +		for (i = 0; i < DIV_ROUND_UP(len, 4); i++) {
> +			u32 val = __raw_readl(host->regbase + CMD_DATABUF(i));
> +			int j;

The more usual pattern for these would be to do some unaligned accesses
for the start/end of the buffer to get to alignment and then transfer
the rest as aligned data.

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3AetUACgkQJNaLcl1U
h9AUDggAhbUOC9Q2ExVskNhuRVMVMw5Xq0UlE6+60CYcvZfy1w/TQvgxMcP5764e
+EhXHAQ8BZ+JleaTtcuIoAg7OyBF1OOTQLEsSJ5AE5UOidvK1ft1Pud5D5rIXgYK
kUxszOb2BCfW/rZMaLiKB2ydw1o1TsUEH76COG9+J8rVnLoLC/BwcMat7DVFtnPW
orgevaNjPRUzmWOb7HuSziDLA+okmX+nLF+buquH1LR585JXMbTJd+1cgDk0aJFx
bojmWsK0E1Ra52pwKO7qFdJS9mIzFN6GOVUqT47XhZm3BVmUkTHiugVun+AKT7el
YpZbCCyYdb2H27r96NdBA3Ns3o/fJg==
=PHLm
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
