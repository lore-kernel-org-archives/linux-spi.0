From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] mtd: st_spi_fsm: kill duplicate CMD definitions
Date: Thu, 10 Apr 2014 08:56:53 +0100
Message-ID: <20140410075653.GI4214@lee--X1>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-7-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397064774-31784-7-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> These are also in serial_flash_cmds.h. (FWIW, I didn't know the C
> preprocessor allowed redefinitions without warning like this.)

Right, I would have expected that too. I'll investigate.

JOOI, have you build tested your changes?

Non-tested:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 36 ------------------------------=
------
>  1 file changed, 36 deletions(-)
>=20
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/s=
t_spi_fsm.c
> index 30082a09f68b..122a8a14ef84 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -201,42 +201,6 @@
> =20
>  #define STFSM_MAX_WAIT_SEQ_MS  1000     /* FSM execution time */
> =20
> -/* Flash Commands */
> -#define FLASH_CMD_WREN         0x06
> -#define FLASH_CMD_WRDI         0x04
> -#define FLASH_CMD_RDID         0x9f
> -#define FLASH_CMD_RDSR         0x05
> -#define FLASH_CMD_RDSR2                0x35
> -#define FLASH_CMD_WRSR         0x01
> -#define FLASH_CMD_SE_4K                0x20
> -#define FLASH_CMD_SE_32K       0x52
> -#define FLASH_CMD_SE           0xd8
> -#define FLASH_CMD_CHIPERASE    0xc7
> -
> -#define FLASH_CMD_READ         0x03    /* READ */
> -#define FLASH_CMD_READ_FAST    0x0b    /* FAST READ */
> -#define FLASH_CMD_READ_1_1_2   0x3b    /* DUAL OUTPUT READ */
> -#define FLASH_CMD_READ_1_2_2   0xbb    /* DUAL I/O READ */
> -#define FLASH_CMD_READ_1_1_4   0x6b    /* QUAD OUTPUT READ */
> -#define FLASH_CMD_READ_1_4_4   0xeb    /* QUAD I/O READ */
> -
> -#define FLASH_CMD_WRITE                0x02    /* PAGE PROGRAM */
> -#define FLASH_CMD_WRITE_1_1_2  0xa2    /* DUAL INPUT PROGRAM */
> -#define FLASH_CMD_WRITE_1_2_2  0xd2    /* DUAL INPUT EXT PROGRAM */
> -#define FLASH_CMD_WRITE_1_1_4  0x32    /* QUAD INPUT PROGRAM */
> -#define FLASH_CMD_WRITE_1_4_4  0x12    /* QUAD INPUT EXT PROGRAM */
> -
> -#define FLASH_CMD_EN4B_ADDR    0xb7    /* Enter 4-byte address mode =
*/
> -#define FLASH_CMD_EX4B_ADDR    0xe9    /* Exit 4-byte address mode *=
/
> -
> -/* READ commands with 32-bit addressing (N25Q256 and S25FLxxxS) */
> -#define FLASH_CMD_READ4                0x13
> -#define FLASH_CMD_READ4_FAST   0x0c
> -#define FLASH_CMD_READ4_1_1_2  0x3c
> -#define FLASH_CMD_READ4_1_2_2  0xbc
> -#define FLASH_CMD_READ4_1_1_4  0x6c
> -#define FLASH_CMD_READ4_1_4_4  0xec
> -
>  /* S25FLxxxS commands */
>  #define S25FL_CMD_WRITE4_1_1_4 0x34
>  #define S25FL_CMD_SE4          0xdc

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
