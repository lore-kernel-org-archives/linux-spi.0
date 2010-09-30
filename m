From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] spi/pl022: compare bitwidth to enums
Date: Thu, 30 Sep 2010 13:34:17 +0200
Message-ID: <AANLkTin6fPnDdSqQiWKH8kTnREV2g8p94HzQQcjcpKLs@mail.gmail.com>
References: <1285840671-9567-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Linus Walleij <linus.walleij@stericsson.com>,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1285840671-9567-1-git-send-email-linus.walleij@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

2010/9/30 Linus Walleij <linus.walleij@stericsson.com>:

> The enums from <linux/amba/pl022.h> are actually off-by-one
> since bitwidth 4 is defined as 0x03, causing weirdness when
> we were trying out some 9-bit peripheral. Fix this by
> comparing to the enum values rather than hardcoded values
> and also fixing the enum to something reasonable.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> (...)
> - =A0 =A0 =A0 if (chip_info->data_size <=3D 8) {
> + =A0 =A0 =A0 if (chip_info->data_size <=3D SSP_DATA_BITS_8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "1 <=3D n <=3D8 bits pe=
r word\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->n_bytes =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->read =3D READING_U8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->write =3D WRITING_U8;
> - =A0 =A0 =A0 } else if (chip_info->data_size <=3D 16) {
> + =A0 =A0 =A0 } else if (chip_info->data_size <=3D SSP_DATA_BITS_16) {

I just realized that Kevin Wells patch actually patch away this problem
so merge his patch and disregard this for the optimal solution.

> =A0enum ssp_data_size {
> - =A0 =A0 =A0 SSP_DATA_BITS_4 =3D 0x03, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
> + =A0 =A0 =A0 SSP_DATA_BITS_4 =3D 0x04, SSP_DATA_BITS_5, SSP_DATA_BITS_6,

This is not good because this is used for default register
settings too (I didn't notice, typical).

If anyone still wants a patch for older kernels I can provide a
patch against 2.6.36-rc6 with just the first two hunks.

Yours,
Linus Walleij
