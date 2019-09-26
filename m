From: Colin Ian King <colin.king@canonical.com>
Subject: re: spi: Add call to spi_slave_abort() function when spidev driver is
 released
Date: Thu, 26 Sep 2019 11:00:19 +0100
Message-ID: <f4db4595-7673-f2ae-4222-cbb9c2d771f9@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Lukasz Majewski <lukma@denx.de>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Static analysis with Coverity has detected an potential dereference of a
free'd object with commit:

commit 9f918a728cf86b2757b6a7025e1f46824bfe3155
Author: Lukasz Majewski <lukma@denx.de>
Date:   Wed Sep 25 11:11:42 2019 +0200

    spi: Add call to spi_slave_abort() function when spidev driver is
released

In spidev_release() in drivers/spi/spidev.c the analysis is as follows:

600static int spidev_release(struct inode *inode, struct file *filp)
601{
602        struct spidev_data      *spidev;
603
604        mutex_lock(&device_list_lock);

   1. alias: Assigning: spidev = filp->private_data. Now both point to
the same storage.

605        spidev = filp->private_data;
606        filp->private_data = NULL;
607
608        /* last close? */
609        spidev->users--;

   2. Condition !spidev->users, taking true branch.

610        if (!spidev->users) {
611                int             dofree;
612
613                kfree(spidev->tx_buffer);
614                spidev->tx_buffer = NULL;
615
616                kfree(spidev->rx_buffer);
617                spidev->rx_buffer = NULL;
618
619                spin_lock_irq(&spidev->spi_lock);

   3. Condition spidev->spi, taking false branch.

620                if (spidev->spi)
621                        spidev->speed_hz = spidev->spi->max_speed_hz;
622
623                /* ... after we unbound from the underlying device? */

   4. Condition spidev->spi == NULL, taking true branch.

624                dofree = (spidev->spi == NULL);
625                spin_unlock_irq(&spidev->spi_lock);
626

   5. Condition dofree, taking true branch.

627                if (dofree)

   6. freed_arg: kfree frees spidev.

628                        kfree(spidev);
629        }
630#ifdef CONFIG_SPI_SLAVE

   CID 89726 (#1 of 1): Read from pointer after free (USE_AFTER_FREE)
7. deref_after_free: Dereferencing freed pointer spidev.

631        spi_slave_abort(spidev->spi);
632#endif
633        mutex_unlock(&device_list_lock);
634
635        return 0;
636}

The call to spi_slave_abort() on spidev is reading an earlier kfree'd
spidev.

Colin
