From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH v3 2/3] spi: of: allow instantiating slaves without a driver
Date: Tue, 19 Jul 2016 10:31:54 +0200
Message-ID: <CAOMqctS0+eaufGdsGV96h3SJCOGrjhaAL1aRxxkMRtpK_p_3YQ@mail.gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com> <42e65e5c714f079cb4b85761e59fb700d4550a26.1468880530.git.hramrach@gmail.com>
 <20160718230234.GX30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160718230234.GX30372@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

On 19 July 2016 at 01:02, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 19, 2016 at 12:35:41AM +0200, Michal Suchanek wrote:
>> SPI slave devices are not created when looking up driver for the slave
>> fails. Create a device anyway so it can be used with spidev.
>
>>       rc = of_modalias_node(nc, spi->modalias,
>>                               sizeof(spi->modalias));
>>       if (rc < 0) {
>> -             dev_err(&master->dev, "cannot find modalias for %s\n",
>> +             dev_warn(&master->dev, "cannot find modalias for %s\n",
>
> Nothing has change since you last sent this patch which converts
> of_modailias_node() into something which looks up a driver so the
> patch description still fails to describe what the patch is doing.
>
> Please don't ignore review comments, people are generally making them
> for a reason and are likely to have the same concerns if issues remain
> unaddressed.  Having to repeat the same comments can get repetitive and
> make people question the value of time spent reviewing.  If you disagree
> with the review comments that's fine but you need to reply and discuss
> your concerns so that the reviewer can understand your decisions.

I have split the other part of the patch. Regarding the commit message
if you have suggestion for better wording please do share it.

>From my point of view the conceptual change described in the commit message
is that whenever SPI slave node is encountered in devicetree you get either
a device with active driver or a device with no driver whereas
previously you either
got a device with active driver or no device. So yes, it's about
allowing SPI slave
devices without a driver bound to them.

The technical implementation detail that can be seen in the patch is
ignoring the
return value of of_modalias_node.

Thanks

Michal
