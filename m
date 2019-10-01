From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: Avoid calling spi_slave_abort() with kfreed spidev
Date: Tue, 1 Oct 2019 12:00:07 +0200
Message-ID: <CAMuHMdWh7xPZqp4J1qG22dXk_g=Q1WtQ9Xu-r3wiFOL3kW+WBg@mail.gmail.com>
References: <20191001090657.25721-1-lukma@denx.de> <CAMuHMdWHTaPkzTdzz-j1rFeT=aAEG+J46fgKiPYrXoAR_DTvtQ@mail.gmail.com>
 <20191001113420.032dbfef@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001113420.032dbfef@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lukasz,

On Tue, Oct 1, 2019 at 11:34 AM Lukasz Majewski <lukma@denx.de> wrote:
> > On Tue, Oct 1, 2019 at 11:07 AM Lukasz Majewski <lukma@denx.de> wrote:
> > > Call spi_slave_abort() only when the spidev->spi is !NULL and the
> > > structure hasn't already been kfreed.
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>

> > > --- a/drivers/spi/spidev.c
> > > +++ b/drivers/spi/spidev.c
> > > @@ -600,15 +600,16 @@ static int spidev_open(struct inode *inode,
> > > struct file *filp) static int spidev_release(struct inode *inode,
> > > struct file *filp) {
> > >         struct spidev_data      *spidev;
> > > +       int dofree;
> > >
> > >         mutex_lock(&device_list_lock);
> > >         spidev = filp->private_data;
> > >         filp->private_data = NULL;
> > > +       dofree = 0;
> > >
> > >         /* last close? */
> > >         spidev->users--;
> > >         if (!spidev->users) {
> > > -               int             dofree;
> > >
> > >                 kfree(spidev->tx_buffer);
> > >                 spidev->tx_buffer = NULL;
> > > @@ -628,7 +629,8 @@ static int spidev_release(struct inode *inode,
> > > struct file *filp) kfree(spidev);
> > >         }
> > >  #ifdef CONFIG_SPI_SLAVE
> > > -       spi_slave_abort(spidev->spi);
> > > +       if (!dofree)
> > > +               spi_slave_abort(spidev->spi);
> >
> > Can spidev->spi be NULL, if spidev->users != 0?
>
> No, it shouldn't be.
>
> The "dofree" is only set to true (the spidev->spi == NULL condition is
> checked) if there are no references (spidev->users == 0).
>
> The if (!dofree) prevents from calling spi_slave_abort() when
> spidev->spi == NULL and spidev is kfree'd.

If spidev->users != 0, the block checking spidev->spi == NULL is never
executed, and spi_slave_abort() will be called.

I'm wondering if spidev->spi can be NULL if spidev->users is still positive.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
