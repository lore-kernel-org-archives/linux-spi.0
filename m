From: Kuldeep Singh <kuldeep.singh-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [EXT] [PATCH 9/9] mtd: spi-nor: add support for Cypress Semper
 flash
Date: Thu, 13 Feb 2020 10:36:48 +0000
Message-ID: <AM0PR0402MB3556ACFC1EAB0FBD98099309E01A0@AM0PR0402MB3556.eurprd04.prod.outlook.com>
References: <20200211133348.15558-1-p.yadav@ti.com>
 <20200211133348.15558-10-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
To: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200211133348.15558-10-p.yadav-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+Alexander

Hi Tudor, Vignesh, Pratyush,

> -----Original Message-----
> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-kernel-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> On Behalf Of Pratyush Yadav
> Sent: Tuesday, February 11, 2020 7:04 PM
> To: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>; Miquel Raynal
> <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>; Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>;
> Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>; Mark Brown
> <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>; Pratyush Yadav
> <p.yadav-l0cyMroinI0@public.gmane.org>
> Subject: [EXT] [PATCH 9/9] mtd: spi-nor: add support for Cypress Semper
> flash
>=20
> Caution: EXT Email
>=20
> The Cypress Semper flash is an xSPI compliant octal DTR flash. Add suppor=
t
> for using it in octal DTR mode.
>=20
> The flash by default boots in a hybrid sector mode. Switch to uniform sec=
tor
> mode on boot. Use the default 20 dummy cycles for a read fast command.
>=20
> The SFDP programming on some older versions of the flash was incorrect.
> Fixes for that are included in the fixup hooks.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 192
> ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   |  14 +++
>  2 files changed, 206 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c
> index 78e3475fa2a9..367e3d0f65aa 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -260,6 +260,12 @@ struct flash_info {
>=20
>  #define JEDEC_MFR(info)        ((info)->id[0])
>=20
> +/* Forward declarations that will be used by s28hs512t_setup(). */
> +static int spi_nor_default_setup(struct spi_nor *nor,
> +                                const struct spi_nor_hwcaps *hwcaps);
> +static void spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
> +                                   u8 opcode, enum spi_nor_protocol
> +proto);
> +
>  /**
>   * spi_nor_spimem_setup_op() - Set up common properties of a spi-mem
> op.
>   * @nor:               pointer to a 'struct spi_nor'
> @@ -2241,6 +2247,65 @@ static int spi_nor_is_locked(struct mtd_info
> *mtd, loff_t ofs, uint64_t len)
>         return ret;
>  }
>=20
> +/**
> + * spi_nor_cypress_octal_enable() - Enable octal DTR mode on Cypress
> flashes.
> + * @nor:               pointer to a 'struct spi_nor'
> + *
> + * This also sets the memory access latency cycles to 20, which is the
> +default
> + * in the spi-nor framework.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int spi_nor_cypress_octal_enable(struct spi_nor *nor) {
> +       struct spi_mem_op op;
> +       u8 *buf =3D nor->bouncebuf;
> +       u8 addr_width =3D 3;
> +       int ret;
> +
> +       /* Use 20 dummy cycles for memory array reads. */
> +       ret =3D spi_nor_write_enable(nor);
> +       if (ret)
> +               return ret;
> +
> +       *buf =3D SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20;
> +       op =3D (struct
> spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG,
> 1),
> +                       SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR2V, 1),
> +                       SPI_MEM_OP_NO_DUMMY,
> +                       SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret) {
> +               dev_warn(nor->dev,
> +                        "failed to set default memory latency value: %d\=
n",
> +                        ret);
> +               return ret;
> +       }
> +       ret =3D spi_nor_wait_till_ready(nor);
> +       if (ret)
> +               return ret;
> +
> +       nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].num_wait_states
> =3D 20;
> +       nor-
> >params.reads[SNOR_CMD_READ_8_8_8_DTR].num_mode_clocks =3D 0;
> +
> +       /* Set the octal and DTR enable bits. */
> +       ret =3D spi_nor_write_enable(nor);
> +       if (ret)
> +               return ret;
> +
> +       *buf =3D SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> +       op =3D (struct
> spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG,
> 1),
> +                       SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR5V, 1),
> +                       SPI_MEM_OP_NO_DUMMY,
> +                       SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret) {
> +               dev_warn(nor->dev, "Failed to enable octal DTR mode\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the
> Status
>   * Register 1.
> @@ -2453,6 +2518,130 @@ static struct spi_nor_fixups gd25q256_fixups =3D
> {
>         .default_init =3D gd25q256_default_init,  };
>=20
> +static int s28hs512t_setup(struct spi_nor *nor,
> +                           const struct spi_nor_hwcaps *hwcaps) {
> +       struct spi_mem_op op;
> +       u8 *buf =3D nor->bouncebuf;
> +       u8 addr_width =3D 3;
> +       int ret;
> +
> +       if (!nor->spimem) {
> +               dev_err(nor->dev,
> +                       "operation not supported for non-spimem drivers\n=
");
> +               return -ENOTSUPP;
> +       }
> +
> +       /*
> +        * This Cypress flash also supports hybrid sector sizes. Make sur=
e
> +        * uniform sector mode is selected. This is done by setting the b=
it
> +        * CFR3N[3].
> +        */
> +       op =3D (struct spi_mem_op)
> +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> +                          SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR3N, 1),
> +                          SPI_MEM_OP_NO_DUMMY,
> +                          SPI_MEM_OP_DATA_IN(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D spi_nor_write_enable(nor);
> +       if (ret)
> +               return ret;
> +
> +       /* Set the uniform sector mode bit. */
> +       *buf |=3D SPINOR_REG_CYPRESS_CFR3N_UNISECT;
> +       op =3D (struct spi_mem_op)
> +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> +                          SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR3N, 1),
> +                          SPI_MEM_OP_NO_DUMMY,
> +                          SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret) {
> +               dev_err(nor->dev, "Failed to change to uniform sector mod=
e\n");
> +               return ret;
> +       }
> +
> +       ret =3D spi_nor_wait_till_ready(nor);
> +       if (ret)
> +               return ret;
> +
> +       return spi_nor_default_setup(nor, hwcaps); }
> +
> +static void s28hs512t_default_init(struct spi_nor *nor) {
> +       nor->params.octal_dtr_enable =3D spi_nor_cypress_octal_enable;
> +       nor->params.setup =3D s28hs512t_setup; }
> +
> +static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor) {
> +       /*
> +        * On older versions of the flash the xSPI Profile 1.0 table has =
the
> +        * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0=
xEE.
> +        */
> +       if (nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].opcode =3D=3D 0)
> +               nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].opcode =3D
> +                       SPINOR_OP_CYPRESS_RD_FAST;
> +
> +       /* This flash is also missing the 4-byte Page Program opcode bit.=
 */
> +       spi_nor_set_pp_settings(&nor-
> >params.page_programs[SNOR_CMD_PP],
> +                               SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
> +       /*
> +        * Since xSPI Page Program opcode is backward compatible with
> +        * Legacy SPI, use Legacy SPI opcode there as well.
> +        */
> +       spi_nor_set_pp_settings(&nor-
> >params.page_programs[SNOR_CMD_PP_8_8_8_DTR],
> +                               SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
> +
> +       /*
> +        * The xSPI Profile 1.0 table advertises the number of additional
> +        * address bytes needed for Read Status Register command as 0 but
> the
> +        * actual value for that is 4.
> +        */
> +       nor->params.rdsr_addr_nbytes =3D 4; }
> +
> +static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
> +                                    const struct sfdp_parameter_header *=
bfpt_header,
> +                                    const struct sfdp_bfpt *bfpt,
> +                                    struct spi_nor_flash_parameter
> +*params) {
> +       struct spi_mem_op op;
> +       u8 *buf =3D nor->bouncebuf;
> +       u8 addr_width =3D 3;
> +       int ret;
> +
> +       /*
> +        * The BFPT table advertises a 512B page size but the page size i=
s
> +        * actually configurable (with the default being 256B). Read from
> +        * CFR3V[4] and set the correct size.
> +        */
> +       op =3D (struct spi_mem_op)
> +               SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> +                          SPI_MEM_OP_ADDR(addr_width,
> SPINOR_REG_CYPRESS_CFR3V, 1),
> +                          SPI_MEM_OP_NO_DUMMY,
> +                          SPI_MEM_OP_DATA_IN(1, buf, 1));
> +       ret =3D spi_mem_exec_op(nor->spimem, &op);
> +       if (ret)
> +               return ret;
> +
> +       if (*buf & SPINOR_REG_CYPRESS_CFR3V_PGSZ)
> +               params->page_size =3D 512;
> +       else
> +               params->page_size =3D 256;
> +
> +       return 0;
> +}
> +
> +static struct spi_nor_fixups s28hs512t_fixups =3D {
> +       .default_init =3D s28hs512t_default_init,
> +       .post_sfdp =3D s28hs512t_post_sfdp_fixup,
> +       .post_bfpt =3D s28hs512t_post_bfpt_fixup, };

As of now, s25fs512s flash also require post_bfpt_fixup proposed in this pa=
tch.
On other thread[1], Alexander was also trying to resolve the same issue.
Since s28hs512t is a hyperflash and require other fixups compared to s25fs5=
12s flash. I have a suggestion to make.

Let's make s28hs512t_ post_bfpt_fixup more generic "spansion_post_bfpt_fixu=
p" and use that fixup for s25fs512s.
A generic name will be better as this bfpt_fixup is needed for other spansi=
on flashes as well and not only for s28hs512t.
Please let me know your views.

Also, please see proposed diff output on top of this patch.

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b557c67..75da26c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2455,7 +2455,7 @@ static void s28hs512t_post_sfdp_fixup(struct spi_nor =
*nor)
        nor->params.rdsr_addr_nbytes =3D 4;
 }
=20
-static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
+static int spansion_post_bfpt_fixup(struct spi_nor *nor,
                                     const struct sfdp_parameter_header *bf=
pt_header,
                                     const struct sfdp_bfpt *bfpt,
                                     struct spi_nor_flash_parameter *params=
)
@@ -2490,7 +2490,11 @@ static int s28hs512t_post_bfpt_fixup(struct spi_nor =
*nor,
 static struct spi_nor_fixups s28hs512t_fixups =3D {
        .default_init =3D s28hs512t_default_init,
        .post_sfdp =3D s28hs512t_post_sfdp_fixup,
-       .post_bfpt =3D s28hs512t_post_bfpt_fixup,
+       .post_bfpt =3D spansion_post_bfpt_fixup,
+};
+
+static struct spi_nor_fixups s25fs512s_fixups =3D {
+       .post_bfpt =3D spansion_post_bfpt_fixup,
 };
=20
 /* NOTE: double check command sets and memory organization when you add
@@ -2732,7 +2736,8 @@ static const struct flash_info spi_nor_ids[] =3D {
        { "s25fl512s",  INFO6(0x010220, 0x4d0080, 256 * 1024, 256,
                        SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
                        SPI_NOR_HAS_LOCK | USE_CLSR) },
-       { "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_=
DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
+       { "s25fs512s",  INFO6(0x010220, 0x4d0081, 256 * 1024, 256, SPI_NOR_=
DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR)
+                       .fixups =3D &s25fs512s_fixups, },
        { "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
        { "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
        { "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },

Thanks=20
Kuldeep

[1] https://patchwork.ozlabs.org/patch/1233915/

> +
>  /* NOTE: double check command sets and memory organization when you
> add
>   * more nor chips.  This current list focusses on newer chips, which
>   * have been converging on command sets which including JEDEC ID.
> @@ -2715,6 +2904,9 @@ static const struct flash_info spi_nor_ids[] =3D {
>         { "s25fl064l",  INFO(0x016017,      0,  64 * 1024, 128, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { "s25fl128l",  INFO(0x016018,      0,  64 * 1024, 256, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>         { "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512, SECT_4K |
> SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +       { "s28hs512t",  INFO(0x345b1a,      0, 256 * 1024, 256, SECT_4K |
> SPI_NOR_OCTAL_DTR_READ)
> +               .fixups =3D &s28hs512t_fixups,
> +       },
>=20
>         /* SST -- large erase sizes are "overlays", "sectors" are 4K */
>         { "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K |
> SST_WRITE) }, diff --git a/include/linux/mtd/spi-nor.h
> b/include/linux/mtd/spi-nor.h index c653f6713cfc..e765272fc0f4 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -150,6 +150,20 @@
>  #define SR2_QUAD_EN_BIT1       BIT(1)
>  #define SR2_QUAD_EN_BIT7       BIT(7)
>=20
> +/* For Cypress flash. */
> +#define SPINOR_OP_RD_ANY_REG                   0x65    /* Read any regis=
ter
> */
> +#define SPINOR_OP_WR_ANY_REG                   0x71    /* Write any regi=
ster
> */
> +#define SPINOR_REG_CYPRESS_CFR2V               0x00800003
> +#define SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20   0x8
> +#define SPINOR_REG_CYPRESS_CFR3N               0x00000004
> +#define SPINOR_REG_CYPRESS_CFR3V               0x00800004
> +#define SPINOR_REG_CYPRESS_CFR3V_PGSZ          BIT(4) /* Page size. */
> +#define SPINOR_REG_CYPRESS_CFR3N_UNISECT       BIT(3) /* Uniform
> sector mode */
> +#define SPINOR_REG_CYPRESS_CFR4V               0x00800005
> +#define SPINOR_REG_CYPRESS_CFR5V               0x00800006
> +#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN    0x3
> +#define SPINOR_OP_CYPRESS_RD_FAST              0xee
> +
>  /* Supported SPI protocols */
>  #define SNOR_PROTO_INST_MASK   GENMASK(23, 16)
>  #define SNOR_PROTO_INST_SHIFT  16
> --
> 2.25.0
