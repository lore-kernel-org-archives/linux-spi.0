From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Thu, 30 Jun 2016 09:47:32 +0200
Message-ID: <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
References: <20160627190949.GB5111@kroah.com> <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com> <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk> <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk> <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk> <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160629180211.GF6247-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 29 June 2016 at 20:02, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jun 29, 2016 at 05:32:48AM +0200, Michal Suchanek wrote:
>
>> The other is to get a generic expansion board and jumper wires. Of
>> course, you will not use all pins of your expansion connector this
>> way. On the other hand using the remaining pins becomes challenging
>> because of the jumper wires you just added. You can use some of the
>> remaining pins as GPIO or add more jumper wires and use some of the
>> remaining functions of the connector for another expansion board.
>
> I'm more than familiar with flying wire systems.  They just aren't a big
> deal here, this is a very technical audience making systems that aren't
> going to have their software meaningfully distributed.  Users making
> flying wire systems really ought to be capable of making the trivial DT
> changes required for them, and if they just hack something not great up
> locally that's not really a problem so long as it works for them.

No. Arduino tutorials made flying wire systems accessible to
non-technical audience. There are similar tutorials for boards running
vendor kernels.

Of course somebody with technical skill has to write the tutorial but
following it requires only understanding of written text - which is
becoming increasingly rare but is still not uncommon skill.

So to write such tutorial you have to give some steps to follow which
are reasonably likely to succeed on wide variety of boards and require
smallest possible changes to the board software.

For mainline this would currently entail

a) loading an overlay that lists spidev directly as compatible and
joke about obtuseness of the kernel developers that force you to read
the log spam

b) failing a) decompile your board devicetree, add the spidev
compatible - apply the overlay manually offline, recompile, and reboot

Adding new_id to spi bus does not simplify the thing at all. You still
have to modify your devicetree. It will at most remove the log spam.

I can even imagine people listing *all* their devices as compatible on
single dt node when the board does not ship with kernel patched for
loading overlays.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
