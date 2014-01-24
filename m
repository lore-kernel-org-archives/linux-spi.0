From: Daniel Santos <danielfsantos@att.net>
Subject: Re: spidev: fix hang when transfer_one_message fails
Date: Thu, 23 Jan 2014 20:21:39 -0600
Message-ID: <52E1CE33.7040309@att.net>
References: <1388965166-27334-1-git-send-email-daniel.santos@pobox.com> <CAMuHMdU0FRi4=YejN+3TLJCwcptHVaaGFTLPyuwzO4NH9=-cUw@mail.gmail.com> <20140123181737.GA11727@sirena.org.uk>
Reply-To: Daniel Santos <daniel.santos@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Santos <daniel.santos@pobox.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140123181737.GA11727@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/23/2014 12:17 PM, Mark Brown wrote:
> On Thu, Jan 23, 2014 at 05:47:02PM +0100, Geert Uytterhoeven wrote:
>
>> Probably your transfer_one_message() forgot to call
>> spi_finalize_current_message()? Is this allowed in case of failure?
> Probably not, or at least we should be consistent about requiring it or
> not.

Hmm, well it sounds like the core problem is a lack of specificity about 
the interface.

1. When a message is being rejected, who is responsible for finalizing 
it, the spi subsystem or the master driver?
2. What does a non-zero return value from transfer() or 
transfer_one_message() mean? transfer() is supposed to just queue the 
message and not sleep, so it would seem appropriate that it would mean 
that the message was rejected due to something being invalid or 
unsupported (or an OOM), etc. , but transfer_one_message() is also where 
*most but not all* drivers transmit the message, so should it mean the 
message was rejected outright for being invalid/unsupported/OOM or 
should it mean a failure, such as EIO while xmitting or both?
3. Is there ever a reason to set the message's status to anything other 
than the return value of transfer()/transfer_one_message()? From a 
cursory review of mainline spi drivers, this appears to vary. Some 
drivers are always returning zero while setting the status upon error, 
some return the status and others still will set the status to one 
value, but return a different error code.

So if a non-zero return value from transfer() or transfer_one_message() 
should also be the status, I'm thinking we can have a small reduction in 
the code footprint if it's done in the spi core. However, I suppose that 
I can't properly discuss this without delving into an almost unrelated 
issue, which may render the point moot.

The only reason I'm using transfer_one_message() at all is because 
transfer() is being deprecated. My driver (currently out-of-tree) 
supports both but will prefer transfer() as long as it hasn't been 
removed or become broken ( which I'm managing via a #if 
LINUX_VERSION_CODE >= KERNEL_VERSION(4,99,99) check: 
https://github.com/daniel-santos/mcp2210-linux/blob/master/mcp2210-spi.c#L143). 
The reason is for this is that the mcp2210 driver has an internal 
command queue that manages (per its requirements) spi messages as well 
as other types of commands to the remote (via USB) device (which is both 
an spi master and gpio chip). From a cursory review of other spi drivers 
in the mainline, I can see that at least two of them do this as well: 
spi-pxa2xx and spi-bfin-v3. So perhaps we need a non-deprecated 
mechanism to do our own queuing and avoid the overhead of the spi core 
providing a thread & queue which we'll just ignore. Then, the core can 
take care of setting status and finalizing when calls to transfer() fail 
(since there should be no ambiguity about this here), but leave that up 
to the driver when calling transfer_one_message()?

Either way, I think that we need to decide and spell it out in the 
kerneldocs.

Daniel
