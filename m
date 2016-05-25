From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Wed, 25 May 2016 11:46:35 -0700
Message-ID: <5745F30B.2040605@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524174140.GE11605@leverpostej> <5744BC76.9090403@gmail.com> <20160525092034.GE1337@leverpostej> <5745C5A3.6060202@gmail.com> <20160525174809.GA8206@sirena.org.uk>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
	Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525174809.GA8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 5/25/2016 10:48 AM, Mark Brown wrote:
> On Wed, May 25, 2016 at 08:32:51AM -0700, Frank Rowand wrote:
>> On 5/25/2016 2:20 AM, Mark Rutland wrote:
> 
>>> Linux for legacy reasons, documenting it as a binding is not necessarily
>>> in anyone's best interest. If we want to document it, we may want to
>>> mark it as deprecated, with a pointer to better alternatives.
> 
>> Lack of documentation and bad documentation are a MAJOR problem for
>> devicetree.
> 
>> Refusing to accept documentation of existing behavior makes no
>> sense to me.
> 
> Sometimes the best thing to do is remove the behaviour, some of these

Yes.  And I have not formed an opinion on whether the existing
behavior should be kept, deprecated, or removed.  I have avoided
commenting on that.


> things are just bugs.  That's not quite the case here but it's in the
> spectrum of things that happen so clearly just blindly documenting
> everything people find happens to work is not great - if something isn't
> being used because it wasn't discoverable sometimes we should be
> thankful for that.  
> 
> Adding documentation for every last implementation that happens to work
> in a given situation through layers of indirection isn't going to help
> with the usability issues DT has, one of the things that the

That is not a reasonable description of this case.

What the kernel does with the spi aliases is not a random unintended
side effect.  It was a deliberate choice.  Read the commit message for
bb29785e0d6d150181704be2efcc3141044625e2


> documentation does is tell both users and other OS vendors (and now I
> guess also people writing ACPI machine descriptions) what they should be
> doing when they implement or use the bindings.  This is especially true
> if the documentation doesn't even cover the intended effects of the
> implementation detail, that's just checkbox documentation.

Yes, it would be great if intended effects were included in the
documentation.


> One of the big problems we have with getting people to write high
> quality bindings is getting them to understand that they're supposed to
> be describing the hardware, not just dumping the current Linux
> implementation into an external data structure.  If that's all we're
> doing then device tree isn't buying us a huge amount, we're just putting
> the same things in another format with worse tooling.  This is like the

Yes, that topic is on my todo list for this year, as I have been sharing
in various venues.  We claim that the devicetree is supposed to be only
describing hardware (with the exception of the chosen node, which is
specified as "describes parameters chosen or specified by the system
firmware at run time") and the status property that the ePAPR defines
as state, but the Linux kernel mostly uses as a flag of whether a
node exists or should be ignored.

In reality, current devicetrees contain information about
  - devicetree specific stuff (eg DT version: /dts-v1/, /include/
    directives, etc)
  - hardware description
  - parameters (the chosen node)
  - state information (the status property)
  - policy
  - configuration

I'm not sure whether I can cram the spi aliases into one of the above
categories.  Maybe there is yet one more category I need to add to
describe the current implementation of devicetree.

I expect the discussion of whether devicetree should contain all of the
above listed categories of information to be long and thoughtful throughout
the rest of the year.


> issues we've got with all the historic bindings that just dumped raw
> numeric constants in the DT - people see those and just write a binding
> which dumps whatever internal constants Linux has into DTs.
> 
> Consider this case, the proposal is:
> 
> | +Normally SPI buses are assigned dynamic bus numbers starting at 32766
> | +and counting downwards.  It is possible to assign the bus number
> | +statically using devicetee aliases.  For example, on the MPC5200 the
>  
> This has no practical meaning as a spec since it doesn't say what a bus
> number either is or means so an implementation can happily ignore it
> with no effect.  The details on how Linux currently does dynamic IDs are
> unhelpful and possibly misleading if the bus gets reinstantiated but
> that's somewhat secondary.

I'm thinking out loud here, let me take a stab at a thought.  We are
doing two things with the bindings in Documentations/devicetree/bindings/.
We are providing a specification, which tells people writing kernel code
what to expect the devicetree to look like.  We are also providing
documentation, telling people writing devicetrees how to describe
their system so that the kernel can use it.

I think that thinking of the bindings as either just a specification or
as just documentation confuses the issue.

I'm not sure where that leads me, but it is worth thinking about.

In this specific case I see the proposed patch as trying to provide
documentation.


> The actual effect Christer is intending to generate is that his systems
> end up with stable names for spidev devices which are a very obvious
> implementation detail of Linux on current systems - using raw spidev
> directly in a binding rather than a compatible string for the attached
> device is something that generates loud warnings since that's not
> something that meets the DT goal of describing the hardware.  With the
> compatible string it's fine since we have a description of the hardware
> and the OS can bind whatever the most suitable support is to the device,
> without we have literally no idea what we're supposed to be controlling.
> 
> Just documenting bus numbers is not going to say anything about how
> Linux supports the particular devices, how spidev works and how
> userspace names devices, nor is it going to help anyone who wants stable
> naming over a class of boards with multiple sockets (eg, board A has two
> SPI sockets on one SPI controller, board B has one controller per
> socket) - the whole using one ramdisk over multiple boards use case that
> Christer mentioned.
> 
> What would seem to be a lot more sensible here would be to define a
> binding for whatever device is being described with some support for
> providing a descriptive name which we can then bring out to userspace
> for it to match on (and perhaps use for the device name so you get
> spidev-socket1, spidev-gpschip or something which would be a lot more
> useful for this type of application since it's easier to map onto the
> physical system).  That directly addresses the need is a more robust and
> general fashion.  I do wonder if such naming support should be at a more
> general level, possibly even DT wide, since it seems like something that
> will apply elsewhere.
> 
> If it's just some raw signals on an expansion connector then this seems
> to be something that should be handled as part of the support for things
> like BeagleBone capes, if no overlay is loaded perhaps that should
> default to raw userspace access to devices.
> 
