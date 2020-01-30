From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
Date: Thu, 30 Jan 2020 18:37:30 +0200
Message-ID: <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>,
        Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>
To: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1580328504-436-1-git-send-email-eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>
> There exists a set of SPI controllers on some POWER processors that may
> be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
> engine that can access and drive the SPI controllers. This driver would
> typically be used by a baseboard management controller (BMC).

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>

> +#include <linux/of.h>

...

> +struct fsi_spi {
> +       struct device *dev;

Isn't fsl->dev the same?
Perhaps kernel doc to explain the difference?

> +       struct fsi_device *fsi;

> +       u32 base;
> +};

...

> +static int fsi_spi_read_reg(struct fsi_spi *ctx, u32 offset, u64 *value)
> +{
> +       int rc;
> +       __be32 cmd_be;
> +       __be32 data_be;

> +       *value = 0ULL;

Usually the pattern is don't pollute output on error condition. Any
reason why you zeroing output beforehand?

> +       cmd_be = cpu_to_be32(offset + ctx->base);
> +       rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
> +       if (rc)
> +               return rc;

> +       return 0;
> +}

...

> +       data_be = cpu_to_be32((value >> 32) & 0xFFFFFFFF);

Redundant & 0xff... part.

> +       data_be = cpu_to_be32(value & 0xFFFFFFFF);

Ditto.

You may use upper_32_bits() / lower_32_bits() instead.

...

> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> +{
> +       int i;

> +       int num_bytes = len > 8 ? 8 : len;

min(len, 8);

> +       for (i = 0; i < num_bytes; ++i)
> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);

Redundant & 0xffULL part.

Isn't it NIH of get_unalinged_be64 / le64 or something similar?

> +       return num_bytes;
> +}

> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> +{

Ditto as for above function. (put_unaligned ...)

> +}

...

> +       dev_info(ctx->dev, "Resetting SPI controller.\n");

info?! Why?

> +       rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                              SPI_FSI_CLOCK_CFG_RESET2);
> +       return rc;

return fsi_spi_write_reg();

...

> +       return ((64 - seq->bit) / 8) - 2;

Too many parentheses.

...

> +static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
> +                                    struct fsi_spi_sequence *seq,
> +                                    struct spi_transfer *transfer)
> +{

> +       int loops = 1;
> +       int idx = 0;
> +       int rc;
> +       u8 len;
> +       u8 rem = 0;

> +       if (transfer->len > 8) {
> +               loops = transfer->len / 8;
> +               rem = transfer->len - (loops * 8);
> +               len = 8;
> +       } else {
> +               len = transfer->len;
> +       }

len = min(transfer->len, 8);

loops = transfer->len / len;
rem = transfer->len % len;

(I think compiler is clever enough to find out that the division can be avoided)

...and drop assignments in definition block.

I didn't look carefully in the implementation, but I believe there is
still room for improvement / optimization.

> +       if (loops > 1) {

> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG,
> +                                      SPI_FSI_COUNTER_CFG_LOOPS(loops - 1));
> +               if (rc) {

> +                       /* Ensure error returns < 0 in this case. */

I didn't get why this case is special? Why not to be consistent with
return value?

> +                       if (rc > 0)
> +                               rc = -rc;
> +
> +                       return rc;
> +               }

> +               return loops;

If we return here the amount of loops...

> +       }
> +
> +       return 0;

...why here is 0?

I think more consistency is required.

> +}

...

> +static int fsi_spi_transfer_data(struct fsi_spi *ctx,
> +                                struct spi_transfer *transfer)
> +{

Can you refactor to tx and rx parts?

> +       return 0;
> +}

...

> +       do {
> +               rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
> +               if (rc)
> +                       return rc;
> +
> +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
> +                             SPI_FSI_STATUS_TDR_FULL |
> +                             SPI_FSI_STATUS_RDR_FULL)) {
> +                       rc = fsi_spi_reset(ctx);
> +                       if (rc)
> +                               return rc;
> +

> +                       continue;

I forgot if this to be infinite loop or if it's going to check
previous seq_state value. In any case this code is a bit fishy. Needs
comments / refactoring.

> +               }
> +
> +               seq_state = status & SPI_FSI_STATUS_SEQ_STATE;
> +       } while (seq_state && (seq_state != SPI_FSI_STATUS_SEQ_STATE_IDLE));

...

> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> +                         SPI_FSI_CLOCK_CFG_MODE |
> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)

> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> +                                      wanted_clock_cfg);

Missed {} ?

> +
> +       return rc;
> +}

...

> +       rc = fsi_slave_read(fsi->slave, 0x2860, &root_ctrl_8,

What is this magic for?

> +                           sizeof(root_ctrl_8));
> +       if (rc)
> +               return rc;

...

> +static int fsi_spi_remove(struct device *dev)
> +{
> +       return 0;
> +}

Why do you need this?

...

> +static struct fsi_driver fsi_spi_driver = {
> +       .id_table = fsi_spi_ids,
> +       .drv = {
> +               .name = "spi-fsi",

> +               .bus = &fsi_bus_type,

Why is it not in the module_fsi_driver() macro?

> +               .probe = fsi_spi_probe,
> +               .remove = fsi_spi_remove,
> +       },
> +};
> +
> +module_fsi_driver(fsi_spi_driver);

-- 
With Best Regards,
Andy Shevchenko
