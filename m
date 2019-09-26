From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: spi: Add call to spi_slave_abort() function when spidev driver is released
Date: Thu, 26 Sep 2019 15:51:58 +0200
Message-ID: <CAMuHMdXm+vUB4iRTsTq64Kg2KC2p7AA1TwFgjc7FuCeiS9EG=Q@mail.gmail.com>
References: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
 <20190926121438.655f1f10@jawa> <CAMuHMdVBrKnA3TJnOEG0G0FVKf7VwQUvLzkmJc7DAX4kvHYWYQ@mail.gmail.com>
 <20190926144342.327a3c66@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Colin Ian King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926144342.327a3c66@jawa>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lukasz,

On Thu, Sep 26, 2019 at 2:49 PM Lukasz Majewski <lukma@denx.de> wrote:
> > On Thu, Sep 26, 2019 at 12:14 PM Lukasz Majewski <lukma@denx.de>
> > wrote:
> > > > Static analysis with Coverity has detected an potential
> > > > dereference of a free'd object with commit:
> > > >
> > > > commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
> > > > Author: Lukasz Majewski <lukma@denx.de>
> > > > Date:   Wed Sep 25 11:11:42 2019 +0200
> > > >
> > > >     spi: Add call to spi_slave_abort() function when spidev
> > > > driver is released

> > > > The call to spi_slave_abort() on spidev is reading an earlier
> > > > kfree'd spidev.
> > >
> > > Thanks for spotting this issue - indeed there is a possibility to
> > > use spidev after being kfree'd.
> >
> > Worse, this makes me realize spidev->spi may be a NULL pointer, which
> > will be dereferenced by spi_slave_abort(), so caching it before the
> > call to kfree() won't work.
>
> The patch as it is now can be fixed as follows:
>
> static int spidev_release(struct inode *inode, struct file *filp)
> {
>         struct spidev_data      *spidev;
>
>         mutex_lock(&device_list_lock);
>         spidev = filp->private_data;
>         filp->private_data = NULL;
>
> #ifdef CONFIG_SPI_SLAVE
>         if (spidev->spi)
>                 spi_slave_abort(spidev->spi);
> #endif
>
>         /* last close? */
>         spidev->users--;
>         if (!spidev->users) {
>                 int dofree;
>
>                 /* free buffers */
>
>                 spin_lock_irq(&spidev->spi_lock);
>                 if (spidev->spi)
>                         spidev->speed_hz = spidev->spi->max_speed_hz;
>
>                 /* ... after we unbound from the underlying device? */
>                 //
>                 // [*]
>                 //
>                 dofree = (spidev->spi == NULL);
>                 spin_unlock_irq(&spidev->spi_lock);
>
>                 if (dofree)
>                         kfree(spidev);
>         }
>
>         mutex_unlock(&device_list_lock);
>
>         return 0;
> }
>
> The question is if we shall call the spi_slave_abort() when cleaning up
> spi after releasing last reference, or each time release callback is
> called ?

TBH, I don't know.  Is it realistic that there are multiple opens?

> > > However, Geert (CC'ed) had some questions about placement of this
> > > function call, so I will wait with providing fix until he replies.
> >
> > Seems like this needs more thought...
>
> Could you be more specific?
>
> Do you mean to move the spi_slave_abort() call just before dofree
> evaluation ? ([*]).

That means the abort is called only for the last user.
And only if the underlying device still exists.  Which means that if it has
disappeared (how can that happen? spidev unbind?), the slave was never
aborted.  Non-spidev slaves can do the abort in their .remove() callbacks
(at least my two sample slave drivers do).
So probably we need some explicit slave abort in the unbind case too?

The more I think about it, the more things I see that can go wrong...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
