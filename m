From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
Date: Thu, 20 Dec 2018 16:23:33 +0000
Message-ID: <6dde2248-da0d-7bd3-801b-b42b2974c038@kontron.de>
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
 <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
 <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi@vger.kernel.org>, arm-soc <arm@kernel.org>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
Content-Language: en-US
Content-ID: <759984B36602BB4590685922A5C16E7E@snt-world.com>
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

On 20.12.18 17:11, Arnd Bergmann wrote:
> On Thu, Dec 20, 2018 at 5:03 PM Schrempf Frieder
> <frieder.schrempf@kontron.de> wrote:
>>
>> Hi Arnd,
>>
>> On 20.12.18 16:50, Arnd Bergmann wrote:
>>> On Sun, Dec 16, 2018 at 9:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
>>>>
>>>> Hi,
>>>>
>>>> As the series cleans up both i.MX/Freescale arm32 and arm64 device
>>>> trees, the pull request is based on a merge of tag imx-dt-4.21 and
>>>> imx-dt64-4.21 that have already been pulled into arm-soc next/dt branch.
>>>> This comes a bit late, and we appreciate it if you can pull it for 4.21,
>>>> as it paves the way for new QSPI driver under SPI framework to land in
>>>> the next release cycle.  Thanks.
>>>
>>> Pulled into next/dt. For my understanding, what is going to happen
>>> with the fsl-quadspi mtd driver? Will it remain as part of the kernel
>>> to support old DTB files, or will that transitions mean those stop
>>> working with new kernels and have to be updated the same way?
>>
>> Thanks for pulling these late changes. The old SPI NOR driver
>> (fsl-quadspi.c) will be replaced by the new SPI driver. Old dtb files
>> will work with the new driver if they already have the reg properties
>> set up correctly (which should be the case, but who knows what setups
>> exist out-of-tree).
> 
> Ok, good.
> 
>> There will be a performance penalty though if you do not set
>> spi-[tx/rx]-bus-width to 4.
> 
> I guess that's acceptable, but what is the reason for requiring
> this? Would it be possible to have the qspi driver add those
> properties and print a warning whenever the dtb doesn't
> already contain them?

As the new driver is a SPI driver, the common rules in 
Documentation/devicetree/bindings/spi/spi-bus.txt apply and 
spi-[tx/rx]-bus-width are defined to default to 1 if not specified.
So we can't set those properties in the driver if they are missing in 
the dtb as we would deviate from the standard, although it would make 
more sense for a *Quad*-SPI driver to default to 4.
