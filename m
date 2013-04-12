From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] SPI: spidev: Add DT compatible string for spidev driver.
Date: Fri, 12 Apr 2013 19:28:39 +0200
Message-ID: <51684447.4040600@metafoo.de>
References: <20130412125621.9645.78102.stgit@localhost>
 <51680C91.6030005@free-electrons.com> <51681743.4020001@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
To: mfuzzey@parkeon.com
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51681743.4020001@parkeon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 04/12/2013 04:16 PM, Martin Fuzzey wrote:
> Hi Maxime,
> 
> On 12/04/13 15:30, Maxime Ripard wrote:
>> I submitted a similar patch quite some time ago [1], and at the time, this
>> patch was found inadequate, and we decided to add the compatible of the
>> particular device that we drive through spidev. 
> 
> Thanks for pointing this out.
> 
>> The rationale behind that is that the device tree is a hardware
>> description, so it's only interested about which device there is on the
>> SPI bus, and not the driver that will eventually handle it. That allows
>> both to have a meaningful devicetree, but also to easily handle the case
>> where a driver for that particular device is finally implemented, since we
>> won't have to change the device tree in itself to reflect this. 
> 
> I'm not sure this is really an advantage of using a "real" compatible string.
> 
> When a kernel driver is finally implemented it will not have the same
> userspace interface as spidev.
> 
> This means that the switch from spidev to the kernel driver will not be
> transparent to userspace.
> 
> So, if a "real" compatible string is used, upon upgrading to a new version
> of the kernel that adds support for that device userspace will break.
> 
> Using a generic compatible string allows the board maintainer to decide when
> to switch by updating the DT.
> 
> Of course, when a custom kernel is being configured and compiled, the
> problem can also be solved by not enabling the new driver but I thought one
> of the goals of DT was to enable using a single distribution style binary
> kernel images on multiple boards.
> 
> Note that my patch only changes the driver, not any DTS.
> Indeed I agree that _using_ a generic compatible string in an _in kernel_
> DTS would be a mistake for the reasons you point out.
> 
> The use case I'm talking about is where a mainline kernel is used but with a
> custom out of tree DTS - why force people to patch the driver for this use
> case?
> 
> Best regards,
> 
> Martin

In my opinion it would be good if we had a mechanism to bind to create a
spidev device for an existing spi device from sysfs. You wouldn't need any
special compilable strings in the spidev driver and could use it for any spi
device you'd like to.

- Lars
