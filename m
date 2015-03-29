From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: bcm2835: remove dependency on handle_err which is
Date: Sun, 29 Mar 2015 19:03:44 +0200
Message-ID: <119C0671-7379-483A-B734-441E6354633E@martin.sperl.org>
References: <72441EEF-C509-433B-9DBA-53A936ED5BDB@martin.sperl.org> <20150329164818.GO1743@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150329164818.GO1743-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 29.03.2015, at 18:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> On Sun, Mar 29, 2015 at 04:03:22PM +0200, Martin Sperl wrote:
>> in spi-for-next
>> 
>> Remove the implementation of handle_err, the function of which was introduced to
>> spi-for-next with patch b716c4ff 
> 
> Why?
> 
> When referencing patches please include the patch title as well as the
> hash, this makes the mail/commit log more directly readable by humans.

This is what I have received and the patch fixes that compile issue...

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi topic/bcm2835
head:   31239b1e92ce1efe9caf5d7d7e901ae02a9ad229
commit: 31239b1e92ce1efe9caf5d7d7e901ae02a9ad229 [6/6] SPI: bcm2835: move to the transfer_one driver model
config: powerpc-allmodconfig (attached as .config)
reproduce:
 wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
 chmod +x ~/bin/make.cross
 git checkout 31239b1e92ce1efe9caf5d7d7e901ae02a9ad229
 # save the attached .config to linux build tree
 make.cross ARCH=powerpc 

All error/warnings:

  drivers/spi/spi-bcm2835.c: In function 'bcm2835_spi_probe':
>> drivers/spi/spi-bcm2835.c:318:8: error: 'struct spi_master' has no member named 'handle_err'
    master->handle_err = bcm2835_spi_handle_err;
          ^

vim +318 drivers/spi/spi-bcm2835.c

  312		master->mode_bits = BCM2835_SPI_MODE_BITS;
  313		master->bits_per_word_mask = SPI_BPW_MASK(8);
  314		master->num_chipselect = 3;
  315		master->setup = bcm2835_spi_setup;
  316		master->set_cs = bcm2835_spi_set_cs;
  317		master->transfer_one = bcm2835_spi_transfer_one;
> 318		master->handle_err = bcm2835_spi_handle_err;
  319		master->dev.of_node = pdev->dev.of_node;
  320	
  321		bs = spi_master_get_devdata(master);


handle_err was introduced to for-next with b716c4ff by Andy Shevchenko
titled: "spi: introduce master->handle_err() callback"

But this is not included in the topic/bcm2835 branch, so the compile fails
because of the missing handle_err in spi_master.

If you merge that one in topic/bcm2835, then you can drop this patch.



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
