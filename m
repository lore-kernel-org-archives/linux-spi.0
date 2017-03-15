From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH] [v2] mtd: spi-nor: don't include linux/mtd/cfi.h from
 header
Date: Wed, 15 Mar 2017 11:40:08 +0100
Message-ID: <c0685146-7a60-355d-708a-2a8f5016c199@atmel.com>
References: <20170314214239.3921342-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: Michal Suchanek <hramrach@gmail.com>, linux-kernel@vger.kernel.org,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>
To: Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, David
 Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger
 <richard@nod.at>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170314214239.3921342-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Arnd,

+Mark Brown and Kamal Dasu

Le 14/03/2017 =E0 22:42, Arnd Bergmann a =E9crit :
> The newly added broadcom qspi driver in drivers/spi produces a build
> warning when CONFIG_MTD is disabled:
> =

> include/linux/mtd/cfi.h:76:2: #warning No CONFIG_MTD_CFI_Ix selected. No =
NOR chip support can work. [-Werror=3Dcpp]
> =

> Since drivers like this one don't actually need the cfi.h header,
> we can just remove it from the spi-nor.h file and add it to
> the only place that actually needs it.
>

Actually this build warning highlights an issue in the broadcom qspi
driver. Indeed this driver implements the ->spi_flash_read handler with
bcm_qspi_flash_read() but this latest function is not correct.

I will provide more details and explanations below, mainly for SPI guys,
but if you want to go directly to my conclusion, please just skip the
""" section :)


""""
The second argument of the ->spi_flash_read handler is a pointer to a
'struct spi_flash_read_message'. This structure has a 'read_opcode'
member providing the SPI controller driver with the value of the op code
to be sent at the very beginning of the SPI message.

This 'read_opcode' depends on many parameters such as the memory
manufacturer, the number of I/O lines used to send the SPI message, the
number of bytes of the address, ...
The spi-nor framework is responsible for selecting the right settings
for (Fast) Read, hence read_opcode, Page Program and Sector Erase
operations. Those choices are made according to both the SPI memory and
controller hardware capabilities. This process can be a little bit
complex to always find a working combination.

Hence SPI controller drivers implementing the ->spi_flash_read handler
should use the settings provided inside the 'struct
spi_flash_read_message' parameter but should never try to guess or
override those settings. So there is no reason for
bcm_qspi_bspi_set_flex_mode() to initialize its 'command' local variable
with SPINOR_OP_READ* macros. Instead, this 'command' variable should be
initialize with msg->read_opcode.

Also the actual number of dummy cycles depends on both the read opcode
and the memory manufacturer. So the values hardcoded in
bcm_qspi_bspi_set_flex_mode() work for some manufacturers but not all.
Once again, the spi-nor framework is responsible for filling the
'dummy_bytes' member of the 'struct spi_flash_read_message' with the
right value.

For instance, the factory settings for the Fast Read 1-4-4 (Quad I/O)
command are:

                        Mode cycles  Wait state cycles   Dummy cycles
Macronix MX25L25673G:             2                  4              6
Spansion S25FL512S:               2                  4              6
Micron N25Q512:                   1                  9             10

The number of dummy clock cycles being the sum of the numbers of mode
and wait state cycles. This shows that the spi-bcm-qspi driver uses
wrong settings for Fast Read 1-4-4 commands at least with Micron memories.

Besides, even for a given memory part, the 'read_opcode', 'addr_width'
and 'dummy_bytes' values of the 'struct spi_flash_read_message' are not
fixed. Indeed, the spi_flash_read() function can be used by the spi-nor
framework to perform Read SFDP commands. The Read SFDP command has a
dedicated op code (5Ah), a fixed number of address bytes (always 3, even
for memories > 128Mbit using 4-byte address commands), and a fixed
number of dummy clock cycles (8).
So this is another good reason not to hardcode the memory settings in
any SPI controller driver.
"""


All this to say that the spi-bcm-qspi.c driver includes the
<linux/mtd/spi-nor.h> file only to use the SPINOR_OP_READ* macros and,
as explained above, this is not a needed. Once the spi-bcm-qspi.c fixed,
we could simply remove the #include <linux/mtd/spi-nor.h> line then the
build warning would disappear as well.
Actually, IMHO, no SPI controller driver should include the
<linux/mtd/spi-nor.h> file at all. If it is included anyway, well I
guess we should not be surprised to find dependencies to the MTD sub-system.

So I think this patch only hides the real issue in the broadcom driver
but doesn't fix it. Then I'm sorry but I won't accept it.


Best regards,

Cyrille

> Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> Link: https://patchwork.kernel.org/patch/9334097/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: move definitions as suggested by Ezequiel
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++++
>  include/linux/mtd/spi-nor.h   | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> =

> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 747645c74134..7d7ad84f739f 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -21,8 +21,24 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/of_platform.h>
>  #include <linux/spi/flash.h>
> +#include <linux/mtd/cfi.h>
>  #include <linux/mtd/spi-nor.h>
>  =

> +/*
> + * Manufacturer IDs
> + *
> + * The first byte returned from the flash after sending opcode SPINOR_OP=
_RDID.
> + * Sometimes these are the same as CFI IDs, but sometimes they aren't.
> + */
> +#define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
> +#define SNOR_MFR_GIGADEVICE	0xc8
> +#define SNOR_MFR_INTEL		CFI_MFR_INTEL
> +#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
> +#define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
> +#define SNOR_MFR_SPANSION	CFI_MFR_AMD
> +#define SNOR_MFR_SST		CFI_MFR_SST
> +#define SNOR_MFR_WINBOND	0xef /* Also used by some Spansion */
> +
>  /* Define max times to check status register before we give up. */
>  =

>  /*
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index f2a718030476..716a8f79784e 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -11,25 +11,9 @@
>  #define __LINUX_MTD_SPI_NOR_H
>  =

>  #include <linux/bitops.h>
> -#include <linux/mtd/cfi.h>
>  #include <linux/mtd/mtd.h>
>  =

>  /*
> - * Manufacturer IDs
> - *
> - * The first byte returned from the flash after sending opcode SPINOR_OP=
_RDID.
> - * Sometimes these are the same as CFI IDs, but sometimes they aren't.
> - */
> -#define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
> -#define SNOR_MFR_GIGADEVICE	0xc8
> -#define SNOR_MFR_INTEL		CFI_MFR_INTEL
> -#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
> -#define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
> -#define SNOR_MFR_SPANSION	CFI_MFR_AMD
> -#define SNOR_MFR_SST		CFI_MFR_SST
> -#define SNOR_MFR_WINBOND	0xef /* Also used by some Spansion */
> -
> -/*
>   * Note on opcode nomenclature: some opcodes have a format like
>   * SPINOR_OP_FUNCTION{4,}_x_y_z. The numbers x, y, and z stand for the n=
umber
>   * of I/O lines used for the opcode, address, and data (respectively). T=
he
> =



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
