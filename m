From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Date: Wed, 13 Jun 2018 06:14:54 +0000
Message-ID: <DB6PR0402MB28382277E48A9243B5C38FAF997E0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180611114916.351ed272@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        David Wolfe <david.wolfe@nxp.com>, Han Xu <han.xu@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NeilBrown <neil@brown.name>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611114916.351ed272@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,


-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Monday, June 11, 2018 3:19 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: linux-mtd@lists.infradead.org; boris.brezillon@free-electrons.com; frie=
der.schrempf@exceet.de; computersforpeace@gmail.com; David Wolfe <david.wol=
fe@nxp.com>; Han Xu <han.xu@nxp.com>; festevam@gmail.com; marek.vasut@gmail=
.com; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; linux-spi@vger.kerne=
l.org; linux-kernel@vger.kernel.org; NeilBrown <neil@brown.name>
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes

Hi Yogesh,

Unrelated note: no need to send your patches to both boris.brezillo@free-el=
ectrons.com and boris.brezillo@bootlin.com, just use the latter.

Ok, Sure.

On Mon, 11 Jun 2018 14:48:14 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Honour max_data_size for spi-nor writes

^ This is no longer relevant.

> In new spi-mem framework, data size to be written is being calculated=20
> using spi_mem_adjust_op_size().
> This can return value less than nor->page_size.
>=20
> Add check value of data size return from API spi_mem_adjust_op_size()=20
> with the actual requested data size and write, max, only supported=20
> data size.

This part is not clear.

Also, I'd prefer to have this patch split in 2:
1/ one patch removing the check in spi_nor_write() 2/ and the second patch =
removing the while() loop in m25p80_write()

How about the following commit messages for those 2 patches:

1:
"
mtd: spi-nor: Support controllers with limited TX FIFO size

Some SPI controllers can't write nor->page_size bytes in a single step beca=
use their TX FIFO is too small.

Allow nor->write() to return a size that is smaller than the requested writ=
e size to gracefully handle this case.
"

2:
"
mtd: devices: m25p80: Make sure WRITE_EN is issued before each write

Some SPI controllers can't write nor->page_size bytes in a single step beca=
use their TX FIFO is too small, but when that happens we should make sure a=
 WRITE_EN command is issued before each write access.

The core is already taking care of that, so all we have to do here is retur=
n the actual number of bytes that were written during the
spi_mem_exec_op() operation.
"

Both patches send [1][2]

--
Regards
Yogesh Gaur.

>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/mtd/devices/m25p80.c  | 23 ++++++++--------------- =20
> drivers/mtd/spi-nor/spi-nor.c |  7 -------
>  2 files changed, 8 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/mtd/devices/m25p80.c=20
> b/drivers/mtd/devices/m25p80.c index e84563d..60224fe 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -72,7 +72,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t=
 to, size_t len,
>  				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
>  				   SPI_MEM_OP_DUMMY(0, 1),
>  				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
> -	size_t remaining =3D len;
>  	int ret;
> =20
>  	/* get transfer protocols. */
> @@ -84,22 +83,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff=
_t to, size_t len,
>  	if (nor->program_opcode =3D=3D SPINOR_OP_AAI_WP && nor->sst_write_secon=
d)
>  		op.addr.nbytes =3D 0;
> =20
> -	while (remaining) {
> -		op.data.nbytes =3D remaining < UINT_MAX ? remaining : UINT_MAX;
> -		ret =3D spi_mem_adjust_op_size(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D spi_mem_exec_op(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> +	ret =3D spi_mem_adjust_op_size(flash->spimem, &op);
> +	if (ret)
> +		return ret;
> +	op.data.nbytes =3D len < op.data.nbytes ? len : op.data.nbytes;
> =20
> -		op.addr.val +=3D op.data.nbytes;
> -		remaining -=3D op.data.nbytes;
> -		op.data.buf.out +=3D op.data.nbytes;
> -	}
> +	ret =3D spi_mem_exec_op(flash->spimem, &op);
> +	if (ret)
> +		return ret;
> =20
> -	return len;
> +	return op.data.nbytes;
>  }
> =20
>  /*
> diff --git a/drivers/mtd/spi-nor/spi-nor.c=20
> b/drivers/mtd/spi-nor/spi-nor.c index 5bfa36e..3e63543 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, lof=
f_t to, size_t len,
>  			goto write_err;
>  		*retlen +=3D written;
>  		i +=3D written;
> -		if (written !=3D page_remain) {
> -			dev_err(nor->dev,
> -				"While writing %zu bytes written %zd bytes\n",
> -				page_remain, written);
> -			ret =3D -EIO;
> -			goto write_err;
> -		}
>  	}
> =20
>  write_err:

[1] https://patchwork.ozlabs.org/patch/928677/
[2] https://patchwork.ozlabs.org/patch/928678/
