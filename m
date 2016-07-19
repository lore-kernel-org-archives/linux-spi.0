From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi slaves.
Date: Tue, 19 Jul 2016 17:32:24 +0200
Message-ID: <CAOMqctRTNRTKKLVMXgxzdJEq0giRp5f8ujAUf-gUty9fSjqGXA@mail.gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com> <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
 <20160718225952.GW30372@sirena.org.uk> <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
 <20160719124409.GC30372@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160719124409.GC30372@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 19 July 2016 at 14:44, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 19, 2016 at 01:17:52PM +0200, Michal Suchanek wrote:
>> On 19 July 2016 at 00:59, Mark Brown <broonie@kernel.org> wrote:
>
>> Looking into SPI more this whole point is mostly moot, anyway. Most of the
>> time the unused CS lines will not be multiplexed to the SPI controller so
>> even if the SPI master tries to use them it does nothing. Also most of the
>> time all the CS lines can be exported as GPIO regardless of their use for SPI.
>> And set to any possible level using the GPIO userspace API.
>
> Your system is not the entire world, Linux has to run on other systems
> too.  There are actual devices out there with inflexible pinmuxing, we
> can't just ignore them.

And they are not ignored.

>
>> In order to reduce the amount of objects and management I appended
>> the link object at the end of struct spi_device.
>
>> Is there a better way?
>
> That seems mostly fine, the problem is one of code review - because the
> patch does many logically distinct things in a single patch it is much
> harder to review than if it were split out.  There's a lot of mechanical
> refactoring which obscures the several more substantive changes that are
> being made at the same time and since most of those substantive changes
> are explicitly described at all it's hard to tell if they're intended or
> doing what is expected.
>
>> > I am getting completely fed up of saying this, it's not OK to just
>> > expose pins to userspace when we have no idea what they are connected
>> > to.
>
>> I am getting fed up with this argument.
>
>> First, this patchset only exposes to userspace pins that are configured as SPI
>> slaves in devicetree.
>
> Are you *absolutely* positive your changes won't do anything on non-DT
> systems?  That definitely doesn't appear to be the case (and shouldn't
> be, not all the world is DT), but now I look in more detail what it is
> doing is exposing spidev for each explicitly described slave which is
> substantially more safe and does address the main problem with
> undescribed devices.
>
> Please split this up so it can be reviewed, providing clear and specific
> descriptions of each individual change (as covered in
> SubmittingPatches).

OK, splitting this into multiple incremental patches should work better.

>
> This:
>
>> -       status = register_chrdev(SPIDEV_MAJOR, "spi", &spidev_fops);
>> +       status = register_chrdev(SPIDEV_MAJOR, "spidev", &spidev_fops);
>
> also looks like a needless ABI change

ABI change to what?

The spidev ABI should be the IOCTLs on /dev/spidev*. These are preserved.

What parts of the kernel or userspace should depend on spidev
devices belonging to class spi?

Changing this is deliberate so SPI devices can be enumerated walking
the bus without seeing the spidev devices. Or spidev devices can be
enumerated walking the spidev class. No need to maintain a list.

> and the removal of the locking on
> minor device allocation seems concerning and at least needs to be
> covered in the changelog.

This particular part should be covered by the SPI device list lock
because the attach/detach function should be only called with
the lock held.

It's certainly worth documenting as a separate change if it's still preserved
once spidev is again modularized.

>
>> The fact that devicetree does not allow talking to a SPI device from userspace
>> without telling kernel what kind of protocol userspace is using is a regression
>> from using board files. The kernel has no business knowing that. When you
>> use a userspace driver it's userspace's job to manage protocols and devices.
>
> The system as a whole, including both the kernel and userspace, has
> every business knowing what the hardware is so it can understand how to
> control it.  Userspace is no more able to discover what the magic
> undescribed bits of hardware are automatically than the kernel is
> without help from a hardware description, the DT isn't just something
> for the kernel once you have userspace drivers.
>
> Directly enumerating spidev wasn't an especially great idea for board
> files either, it was just an expedient hack that worked when the
> hardware description was entirely in kernel and much easier to just go
> and change but now we have an external ABI for hardware description and
> we have to expect that people will use it as such.
>
>> The purpose of this patchset is for the userspace applications to continue doing
>> so with devicetree based systems without the need to fabricate fake hardware
>> description. And the hardware description will necessarily be fake in the case
>> when it is in fact userspace implementing and managing the drivers.
>
> If userspace is managing to figure out how to control the device then
> providing a description of the hardware is clearly within the bounds of
> possibility and there is no need to fake anything.

However. maintaining the hardware description in multiple places is
redundant and error-prone. Since the userspace somehow managed to
figure it out on legacy kernels without devicetree it does not need
the information in devicetree. Users of such software will not want the
hardware description in devicetree and if forced to provide it will stub it out.

Also world is not all devicetree so userspace applications should be free
to consult devicetree information if present or use whatever other means
at their disposal to determine what hardware they are dealing with.
When portability is a concern consulting devicetree may be a secondary
source at best.

Thanks

Michal
