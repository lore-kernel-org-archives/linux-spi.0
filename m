From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting queue_kthread_work before the message is unmapped
Date: Sat, 9 May 2015 08:40:41 +0200
Message-ID: <3374181B-61BE-4DAA-9D92-68B43BEF3E1D@martin.sperl.org>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8C375B28-1C09-4545-8A5B-78F6CD04102F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Forwarded to linux-spi as well for documentation, was only sent to linux-rpi-kernel.
Apologies.


> On 08.05.2015, at 22:02, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> 
> Hi!
> 
> It seems as if there is a potential race inside spi_finalize_current_message
> in this section of drivers/spi/spi.c
> 
> void spi_finalize_current_message(struct spi_master *master)
> {
>        struct spi_message *mesg;
>        unsigned long flags;
>        int ret;
> 
>        spin_lock_irqsave(&master->queue_lock, flags);
>        mesg = master->cur_msg;
>        master->cur_msg = NULL;
> 
>        queue_kthread_work(&master->kworker, &master->pump_messages);
>        spin_unlock_irqrestore(&master->queue_lock, flags);
> 
>        spi_unmap_msg(master, mesg);
> ...
> 
> The kernel thread gets scheduled before spi_unmap_msg is getting called
> this is obviously not an issue when master->dummy_rx and master->dummy_tx
> are NULL, but if a driver sets SPI_MASTER_MUST_RX or SPI_MASTER_MUST_TX,
> then master->dummy_rx and master->dummy_tx may get freed inside the
> pump thread _before_ the memory is unmapped inside finalize.
> 
> This can result in:
> [   83.774518] page:db7ba030 count:0 mapcount:0 mapping:  (null) index:0x0
> [   83.783143] flags: 0x200(arch_1)
> [   83.791861] page dumped because: PAGE_FLAGS_CHECK_AT_PREP flag set
> [   83.803147] bad because of flags:
> [   83.808397] flags: 0x200(arch_1)
> ...
> [   83.813703] [<c012a2d4>] (__kmalloc_track_caller) from [<c01050d8>] (krealloc+0x60/0xb8)
> [   83.813734] [<c01050d8>] (krealloc) from [<c03cce08>] (__spi_pump_messages+0x70c/0x79c)
> [   83.813764] [<c03cce08>] (__spi_pump_messages) from [<c03cd0b4>] (__spi_sync+0x21c/0x22c)
> [   83.813789] [<c03cd0b4>] (__spi_sync) from [<c03cd100>] (spi_sync+0x1c/0x20)
> [   83.813871] [<c03cd100>] (spi_sync) from [<bf0341c4>] (fbtft_write_spi+0x90/0x108 [fbtft])
> 
> Surprisingly Noralf saw this only in a downstream 4.0 kernel but I have not
> experienced such a situation in 4.1-rc2 (and after being able to reproduce
> on downstream 4.0 I still have not been able to trigger such a situation in
> 4.1-rc2).
> 
> Based on the findings by Noralf, the following solves the issue:
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 57a1950..1e662a0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1089,6 +1089,8 @@ void spi_finalize_current_message(struct spi_master *master)
> 	unsigned long flags;
> 	int ret;
> 
> +	spi_unmap_msg(master, master->cur_msg);
> +
> 	spin_lock_irqsave(&master->queue_lock, flags);
> 	mesg = master->cur_msg;
> 	master->cur_msg = NULL;
> @@ -1096,8 +1098,6 @@ void spi_finalize_current_message(struct spi_master *master)
> 	queue_kthread_work(&master->kworker, &master->pump_messages);
> 	spin_unlock_irqrestore(&master->queue_lock, flags);
> 
> -	spi_unmap_msg(master, mesg);
> -
> 	if (master->cur_msg_prepared && master->unprepare_message) {
> 		ret = master->unprepare_message(master, mesg);
> 		if (ret) {
> 
> 
> Note that I am not sure about the locking, so I left unmap outside the
> lock for now.
> 
> Not knowing the semantics of prepare_message it may be possible that move
> may also need to get applied to the master->unprepare_message() call.
> 
> 
> Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
