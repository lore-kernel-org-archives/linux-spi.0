From: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/1] ARM: sun4i: spi: Allow transfers larger
 than FIFO size
Date: Wed, 19 Mar 2014 15:41:07 -0500
Message-ID: <1395261670-19386-1-git-send-email-mr.nuke.me@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDGJVA6QWUDRB6UBVCMQKGQE6GY3ARA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

This is the second iteration of the patches sent yesterday. Per
Maxime's request, I have squashed them into one single patch, and
applied most of the suggestion he made.

As far as only clearing the interrupt _after_ draining the FIFO, I
found that we usually get one extra Rx interrupt per burst if we do
this, so I left the comment in.

>>       /* Enable the interrupts */
>> -     sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
>> -                                              SUN4I_INT_CTL_RF_F34);
>> +     reg = SUN4I_INT_CTL_TC | SUN4I_INT_CTL_RF_F34;
>> +     /* Only enable Tx FIFO interrupt if we really need it */
>> +     if (tx_len > SUN4I_FIFO_DEPTH)
>> +             reg |= SUN4I_INT_CTL_TF_E34;
>> +     sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, reg);
>
> I'd be much dumber than that. Why don't you just enable both
> interrupts all the time if we need larger transfers ?

As I've pointed out previously, this interrupt is PITA, as it triggers
an IRQ storm if enabled without much thought. I found that
(tx_len > SUN4I_FIFO_DEPTH) is the best check for when it's safe to
enable this interrupt.

Alexandru Gagniuc (1):
  ARM: sun4i: spi: Allow transfers larger than FIFO size

 drivers/spi/spi-sun4i.c | 68 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

--
1.8.5.3
