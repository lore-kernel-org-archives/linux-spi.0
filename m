From: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
Date: Tue, 25 Feb 2020 13:45:19 -0600
Message-ID: <afb1b854-5950-c5bb-501f-8c1ee366c13e@linux.ibm.com>
References: <20200203223003.4567-1-eajames@linux.ibm.com>
 <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andrew Jeffery <andrew-zrmu5oMJ5Fs@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-fsi-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 2/24/20 11:08 PM, Joel Stanley wrote:
> Hi Eddie,
>
> Some comments below. For the most part it looks good.
>
> On Mon, 3 Feb 2020 at 22:30, Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org> wrote:
>
>> +FSI-ATTACHED SPI DRIVER
>> +M:     Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
>> +L:     linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Add linux-fsi-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org too
>
>> +S:     Maintained
>> +F:     drivers/spi/spi-fsi.c
>> +static int fsi_spi_write_reg(struct fsi_spi *ctx, u32 offset, u64 value)
>> +{
>> +       int rc;
>> +       __be32 cmd_be;
>> +       __be32 data_be;
>> +
>> +       dev_dbg(ctx->dev, "Write %02x[%016llx].\n", offset, value);
>> +
>> +       data_be = cpu_to_be32(upper_32_bits(value));
>> +       rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA0, &data_be,
>> +                             sizeof(data_be));
>> +       if (rc)
>> +               return rc;
>> +
>> +       data_be = cpu_to_be32(lower_32_bits(value));
> The lower_32_bits cast is redundant (but harmless).
>
>> +       rc = fsi_device_write(ctx->fsi, FSI2SPI_DATA1, &data_be,
>> +                             sizeof(data_be));
>> +       if (rc)
>> +               return rc;
>> +
>> +       cmd_be = cpu_to_be32((offset + ctx->base) | FSI2SPI_CMD_WRITE);
> offset + ctx->base must be less than 2 ^ 31 otherwise the top bit of
> the address collides with the write command. Should we introduce a
> check for that?


Sure, good idea.


>
>> +       rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
>> +       if (rc)
>> +               return rc;
>> +
>> +       return fsi_spi_check_status(ctx);
>> +}
>> +
>> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
>> +{
>> +       int i;
>> +       int num_bytes = min(len, 8);
>> +
>> +       for (i = 0; i < num_bytes; ++i)
>> +               rx[i] = (u8)(in >> (8 * ((num_bytes - 1) - i)));
>> +
>> +       return num_bytes;
>> +}
>> +
>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
>> +{
>> +       int i;
>> +       int num_bytes = min(len, 8);
>> +
>> +       *out = 0ULL;
>> +
>> +       for (i = 0; i < num_bytes; ++i)
>> +               *out |= (u64)tx[i] << (8 * (8 - (i + 1)));
> Did this work with non-8 byte transfers? I think the second 8 should
> be num_bytes.


No it should be 8. From the spec, "The value written to this register 
has to be left aligned." So to send 0x5a (1 byte) should write 
0x5a00000000000000. I've tested this with 1-7 byte writes and obtained 
the correct result.


>
> The loop requires careful reading to check. I wonder if we could do
> this instead, which eliminates a lot duplicated loads and stores and
> is easier to read:
>
>         uint8_t *outp = (uint8_t *)out;
>
>         for (i = 0; i < num_bytes; ++i) {
>                 outp[num_bytes - (i + 1)] = tx[i];
>         }


Yes that should also work (using 8 instead of num_bytes in the assignment).


>
>> +
>> +       return num_bytes;
>> +}
>> +
>> +static int fsi_spi_reset(struct fsi_spi *ctx)
>> +{
>> +       int rc;
>> +
>> +       dev_dbg(ctx->dev, "Resetting SPI controller.\n");
>> +
>> +       rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>> +                              SPI_FSI_CLOCK_CFG_RESET1);
>> +       if (rc)
>> +               return rc;
>> +
>> +       return fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>> +                                SPI_FSI_CLOCK_CFG_RESET2);
>> +}
>> +
>> +static int fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
>> +{
>> +       seq->data |= (u64)val << seq->bit;
>> +       seq->bit -= 8;
>> +
>> +       return ((64 - seq->bit) / 8) - 2;
> I have no idea what this is doing. Add a comment?


Sure. It's adding the next command to the sequence register and 
incrementing it's counter.


>
>> +}
>> +
>> +static int fsi_spi_transfer_init(struct fsi_spi *ctx)
>> +{
>> +       int rc;
>> +       bool reset = false;
>> +       unsigned long end;
>> +       u64 seq_state;
>> +       u64 clock_cfg = 0ULL;
>> +       u64 status = 0ULL;
>> +       u64 wanted_clock_cfg = SPI_FSI_CLOCK_CFG_ECC_DISABLE |
>> +               SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
>> +               FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
>> +
>> +       end = jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
>> +       do {
>> +               if (time_after(jiffies, end))
>> +                       return -ETIMEDOUT;
> How tightly does this loop spin?
>
> Should there be a delay inside of it?


Well, very tightly but I haven't seen it ever do more than a couple of 
iterations. And the timeout is 1 second. Not sure if we need a delay?


>
>> +
>> +               rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
>> +                             SPI_FSI_STATUS_TDR_FULL |
>> +                             SPI_FSI_STATUS_RDR_FULL)) {
>> +                       if (reset)
>> +                               return -EIO;
>> +
>> +                       rc = fsi_spi_reset(ctx);
>> +                       if (rc)
>> +                               return rc;
>> +
>> +                       reset = true;
>> +                       continue;
>> +               }
>> +
>> +               seq_state = status & SPI_FSI_STATUS_SEQ_STATE;
>> +       } while (seq_state && (seq_state != SPI_FSI_STATUS_SEQ_STATE_IDLE));
> ../drivers/spi/spi-fsi.c: In function ‘fsi_spi_transfer_one_message’:
> ../drivers/spi/spi-fsi.c:363:11: warning: ‘seq_state’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    363 |  } while (seq_state && (seq_state != SPI_FSI_STATUS_SEQ_STATE_IDLE));
>        |           ^~~~~~~~~
>

Strange that I don't see this when I compile. I'll move the seq_state 
assignment up.


>> +
>> +       rc = fsi_spi_read_reg(ctx, SPI_FSI_CLOCK_CFG, &clock_cfg);
>> +       if (rc)
>> +               return rc;
>> +
>> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
>> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
>> +                         SPI_FSI_CLOCK_CFG_MODE |
>> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
>> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)
>> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>> +                                      wanted_clock_cfg);
>> +
>> +       return rc;
>> +}
>> +static int fsi_spi_probe(struct device *dev)
>> +{
>> +       int rc;
>> +       u32 root_ctrl_8;
>> +       struct device_node *np;
>> +       int num_controllers_registered = 0;
>> +       struct fsi_device *fsi = to_fsi_dev(dev);
>> +
>> +       /*
>> +        * Check the SPI mux before attempting to probe. If the mux isn't set
>> +        * then the SPI controllers can't access their slave devices.
>> +        */
>> +       rc = fsi_slave_read(fsi->slave, FSI_MBOX_ROOT_CTRL_8, &root_ctrl_8,
>> +                           sizeof(root_ctrl_8));
> Is it correct to stop probing if the mux is not set?
>
> I assume it changes at runtime depending on the state of the host.
> This could mean the driver probes correctly, but fails to work (if the
> mux was set at BMC boot, but then changes).


Right, it could change as the host switches the mux. I'm not sure what 
the correct option here is.


>
> Should it instead block reads/writes when the mux is in the incorrect state?


I see a couple of problems with this.

1) you'd have to check the state of the mux each time you try an operation?

2) how do slave devices (eeproms, etc) get probed up? They'd fail at 
first since operations are blocked, but then your master is probed with 
no easy way to probe the slave?


>
>> +       if (rc)
>> +               return rc;
>> +
>> +       if (!root_ctrl_8) {
>> +               dev_dbg(dev, "SPI mux not set, aborting probe.\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       for_each_available_child_of_node(dev->of_node, np) {
>> +               u32 base;
>> +               struct fsi_spi *ctx;
>> +               struct spi_controller *ctlr;
>> +
>> +               if (of_property_read_u32(np, "reg", &base))
> It looks like this has a device tree binding. Can you add a document
> describing it too?


Sure.


>
>> +                       continue;
>> +
>> +               ctlr = spi_alloc_master(dev, sizeof(*ctx));
>> +               if (!ctlr)
>> +                       break;
>> +
>> +               ctlr->dev.of_node = np;
>> +               ctlr->num_chipselect = of_get_available_child_count(np) ?: 1;
>> +               ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
>> +               ctlr->max_transfer_size = fsi_spi_max_transfer_size;
>> +               ctlr->transfer_one_message = fsi_spi_transfer_one_message;
>> +
>> +               ctx = spi_controller_get_devdata(ctlr);
>> +               ctx->dev = &ctlr->dev;
>> +               ctx->fsi = fsi;
>> +               ctx->base = base + SPI_FSI_BASE;
>> +
>> +               rc = devm_spi_register_controller(dev, ctlr);
>> +               if (rc)
>> +                       spi_controller_put(ctlr);
>> +               else
>> +                       num_controllers_registered++;
>> +       }
>> +
>> +       if (!num_controllers_registered)
>> +               return -ENODEV;
>> +
>> +       return 0;
>> +}
