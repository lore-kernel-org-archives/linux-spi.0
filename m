From: Bernhard Walle <walle@corscience.de>
Subject: Re: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Wed, 02 Feb 2011 12:32:48 +0100
Message-ID: <4D4940E0.8070306@corscience.de>
References: <1296644235-23933-1-git-send-email-walle@corscience.de> <201102021215.29002.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201102021215.29002.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 02.02.2011 12:15, schrieb Arnd Bergmann:
> On Wednesday 02 February 2011, Bernhard Walle wrote:
>> Add the compat_ioctl for operations on /dev/spi* so that 32 bit
>> userspace applications can access SPI. As far as I can see all data
>> structure are already prepared for that, so no additional conversion has
>> to be done.
>>
>> My use case is MIPS with N32 userspace ABI and toolchain, and that was
>> also the platform where I tested it successfully (Cavium Octeon).
>>
>> Signed-off-by: Bernhard Walle <walle@corscience.de>
> 
> I think you now need to #include <linux/compat.h> as well, to get the
> definition of compat_ptr(). Otherwise looks good.

It compiled on my MIPS test environment without that include, but I
adjusted the patch and posted again.

Thanks for reviewing, Arnd!


Regards,
Bernhard
