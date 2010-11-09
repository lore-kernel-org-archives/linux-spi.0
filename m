From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 0/3] spi/xilinx: Merge OF and non-OF drivers
Date: Tue, 9 Nov 2010 14:16:30 -0700
Message-ID: <AANLkTimGwW-v1VQyOM3fmE-6wNf7g64W1YNALh2kd=54@mail.gmail.com>
References: <20101014161724.18966.42340.stgit@localhost6.localdomain6>
 <4CD7FB27.9030804@monstr.eu> <ec622bb7-57d1-4aa2-80f1-65fa4b3fa7eb@VA3EHSMHS033.ehs.local>
 <AANLkTinMoqqMKeEFiD=xHwa5DS+5qY6xN2r236SZQEba@mail.gmail.com> <4CD8F884.30409@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Linn <John.Linn@xilinx.com>,
	spi-devel-general@lists.sourceforge.net,
	richard.rojfors@mocean-labs.com, linux-kernel@vger.kernel.org,
	dbrownell@users.sourceforge.net
To: monstr@monstr.eu
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CD8F884.30409@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 9, 2010 at 12:30 AM, Michal Simek <monstr@monstr.eu> wrote:
> Hi, [cc: David Brownell]
>
> Grant Likely wrote:
>> On Mon, Nov 8, 2010 at 9:34 AM, John Linn <John.Linn@xilinx.com> wro=
te:
>>>> -----Original Message-----
>>>> From: Michal Simek [mailto:monstr@monstr.eu]
>>>> Sent: Monday, November 08, 2010 6:29 AM
>>>> To: grant.likely@secretlab.ca
>>>> Cc: spi-devel-general@lists.sourceforge.net; richard.rojfors@mocea=
n-labs.com; John Linn; linux-
>>>> kernel@vger.kernel.org
>>>> Subject: Re: [RFC PATCH 0/3] spi/xilinx: Merge OF and non-OF drive=
rs
>>>>
>>>> Hi Grant,
>>>>
>>>> Grant Likely wrote:
>>>>> Since of_platform_bus_type has been merged with the platform_bus_=
type,
>>>>> a single platform driver can now support both use cases. =A0This =
patch
>>>>> series merges the two halves of the xilinx_spi device driver.
>>>>>
>>>>> Compile tested only. =A0I haven't booted this yet.
>>>> I have tested it on sp605 and works well. Have you added that patc=
hes
>>>> to your repository? Or are they somewhere else? Who is responsible=
 for?
>>>>
>>>> I would like to also discuss one change which is related mmc_spi k=
ernel driver.
>>>> Let me describe the problem. Microblaze can use dma in all address=
es
>>>> that's why dma_mask is setup to 0xffffffff in of_platform_device_c=
reate.
>>>> Xilinx spi driver doesn't support dma but mmc_spi driver is checki=
ng dma_mask in parent device
>>>> which is xilinx spi driver.
>>>>
>>>> Here is the corresponding the part of code (Expect dma_mask=3Dzero=
 for no dma operations).
>>>> mmc_spi.c:~1395
>>>> =A0 =A0 =A0 if (spi->master->dev.parent->dma_mask) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device =A0 *dev =3D spi->master=
->dev.parent;
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_dev =3D dev;
>>>>
>>>>
>>>> Based on this one our customer came with the following solution to=
 setup
>>>> dma_mask in xilinx_spi to zero and then mmc_spi doesn't setup dma =
operation.
>>>>
>>>> I think that this is nice solution but I would like to be sure tha=
t I didn't miss anything.
>>>> After that i will create proper patch with description.
>>> Seems reasonable to me.
>>
>> Hmmm, that actually is not sane. =A0Ideally, drivers should never be
>> mucking with the dma mask. =A0It is supposed to only be set by the c=
ode
>> actually registering the device. =A0The mmc code should not be looki=
ng
>> at the parent's dma mask to determine if DMA is available; the spi b=
us
>> drivers should be explicitly stating whether or not it supports DMA.
>> The mmc_spi code is doing the wrong thing here.
>
> I have no problem to fix mmc_spi driver but what is the standard way =
how to detect
> DMA capability for this case? This part of code is in mmc_spi from th=
e beginning that's why I am
> wondering that none complain about.
>
> David?
>
> Sorry I don't have HW where I can test it. :-(

Nobody will have *all* the hardware required to test it.  The solution
is actually really hard because it requires auditing all of the spi
bus drivers, figuring out which ones of them support dma, and then
publishing that information in a way readable by the spi_device
drivers.  For the time being, you're solution is probably the most
reasonable.

g.
