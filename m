From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] spi: Add FSI-attached SPI controller driver
Date: Tue, 25 Feb 2020 11:38:40 +0200
Message-ID: <CAHp75VciUDKqxEQw_1bHDmVx19qTZWWjHdfgcJmm4iBwmyFJnA@mail.gmail.com>
References: <20200203223003.4567-1-eajames@linux.ibm.com> <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Eddie James <eajames@linux.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-fsi@lists.ozlabs.org
To: Joel Stanley <joel@jms.id.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XdmdksFctYk96x46XJcxe3yQD3HfAzC8gdF_GXWJHeu2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 25, 2020 at 7:08 AM Joel Stanley <joel@jms.id.au> wrote:
> On Mon, 3 Feb 2020 at 22:30, Eddie James <eajames@linux.ibm.com> wrote:

...

> > +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
> > +{
> > +       int i;
> > +       int num_bytes =3D min(len, 8);
> > +
> > +       for (i =3D 0; i < num_bytes; ++i)
> > +               rx[i] =3D (u8)(in >> (8 * ((num_bytes - 1) - i)));
> > +
> > +       return num_bytes;
> > +}
> > +
> > +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
> > +{
> > +       int i;
> > +       int num_bytes =3D min(len, 8);
> > +
> > +       *out =3D 0ULL;
> > +
> > +       for (i =3D 0; i < num_bytes; ++i)
> > +               *out |=3D (u64)tx[i] << (8 * (8 - (i + 1)));
>
> Did this work with non-8 byte transfers? I think the second 8 should
> be num_bytes.
>
> The loop requires careful reading to check. I wonder if we could do
> this instead, which eliminates a lot duplicated loads and stores and
> is easier to read:
>
>        uint8_t *outp =3D (uint8_t *)out;
>
>        for (i =3D 0; i < num_bytes; ++i) {
>                outp[num_bytes - (i + 1)] =3D tx[i];
>        }

Have you had a chance to read my review of this? What do you think
about put_unaligned*()/get_unaligned*() instead of above?

> > +       return num_bytes;
> > +}

...

> > +static int fsi_spi_transfer_init(struct fsi_spi *ctx)
> > +{
> > +       int rc;
> > +       bool reset =3D false;
> > +       unsigned long end;
> > +       u64 seq_state;
> > +       u64 clock_cfg =3D 0ULL;
> > +       u64 status =3D 0ULL;
> > +       u64 wanted_clock_cfg =3D SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> > +               SPI_FSI_CLOCK_CFG_SCK_NO_DEL |
> > +               FIELD_PREP(SPI_FSI_CLOCK_CFG_SCK_DIV, 4);
> > +
> > +       end =3D jiffies + msecs_to_jiffies(SPI_FSI_INIT_TIMEOUT_MS);
> > +       do {
> > +               if (time_after(jiffies, end))
> > +                       return -ETIMEDOUT;
>
> How tightly does this loop spin?
>
> Should there be a delay inside of it?
>
> > +
> > +               rc =3D fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
> > +               if (rc)
> > +                       return rc;
> > +
> > +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
> > +                             SPI_FSI_STATUS_TDR_FULL |
> > +                             SPI_FSI_STATUS_RDR_FULL)) {
> > +                       if (reset)
> > +                               return -EIO;
> > +
> > +                       rc =3D fsi_spi_reset(ctx);
> > +                       if (rc)
> > +                               return rc;
> > +
> > +                       reset =3D true;
> > +                       continue;
> > +               }
> > +
> > +               seq_state =3D status & SPI_FSI_STATUS_SEQ_STATE;
> > +       } while (seq_state && (seq_state !=3D SPI_FSI_STATUS_SEQ_STATE_=
IDLE));
>
> ../drivers/spi/spi-fsi.c: In function =E2=80=98fsi_spi_transfer_one_messa=
ge=E2=80=99:
> ../drivers/spi/spi-fsi.c:363:11: warning: =E2=80=98seq_state=E2=80=99 may=
 be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   363 |  } while (seq_state && (seq_state !=3D SPI_FSI_STATUS_SEQ_STATE_I=
DLE));
>       |           ^~~~~~~~~

It's bogus warning, though, I think, easy to fix by reshuffling loop body.

> > +       rc =3D fsi_spi_read_reg(ctx, SPI_FSI_CLOCK_CFG, &clock_cfg);
> > +       if (rc)
> > +               return rc;
> > +
> > +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
> > +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
> > +                         SPI_FSI_CLOCK_CFG_MODE |
> > +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
> > +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) !=3D wanted_clock=
_cfg)
> > +               rc =3D fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
> > +                                      wanted_clock_cfg);
> > +
> > +       return rc;
> > +}

--=20
With Best Regards,
Andy Shevchenko
