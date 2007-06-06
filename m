From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
Date: Wed, 06 Jun 2007 13:49:58 -0700
Message-ID: <20070606204741.D4AEB468054@mail82-cpk.bigfish.com>
References: <4666F598.2000004@ru.mvista.com>	
	<20070606180618.C4D861268059@mail88-blu.bigfish.com>
	<fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	Wolfgang Reissnegger <wre@xilinx.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

Grant,

I'm in the process of merging your virtex-dev tree into our
linux-2.6-xlnx tree. I'll be taking care of the necessary changes. They
will show up on the Xilinx git repository soon.

Thanks,
   Wolfgang

Grant Likely wrote:
> On 6/6/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>>
>> Yes, except that microblazes systems run in non-virtex FPGAs...
>>
>> It may be that XILINX_EDK is not the right thing either, but it
>> seemed like the easiest way to have a superset of powerpc and microblaze
>> systems
>>
>> What I'm trying to do is (in concert with Grant's recent configuration
>> changes)
>> having an easy way for a new board configuration to select the Kconfig
>> options for
>> all of the Xilinx drivers.  Namely:
>>
>> config XILINX_ML300
>>         bool "Xilinx-ML300"
>>         select XILINX_VIRTEX_II_PRO
>>         select EMBEDDEDBOOT
>>         help
>>           This option enables support for the Xilinx ML300 evaluation
>> board.
>>
>> config XILINX_VIRTEX_II_PRO
>>         bool
>>         select XILINX_VIRTEX
>>
>> config XILINX_EDK
>>         bool
>>         depends on XILINX_VIRTEX || XILINX_MICROBLAZE
>>         default y
> 
> I don't have any problem with adding XILINX_EDK (or whatever), but
> think particular layout is back-assward.  Rather than XILINX_EDK
> depending on XILINX_VIRTEX/MICROBLAZE, XILINX_VIRTEX/MICROBLAZE should
> 'select' XILINX_EDK and you need to drop the 'default y' line.
> Otherwise the XILINX_EDK option shows up in non-edk config files.
> 
>>
>> config XILINX_GPIO
>>         tristate "Xilinx OPB GPIO Support"
>>         depends on XILINX_EDK
>>         help
>>         This option enables support for Xilinx GPIO.
>>
>>
>> It seems like I'm using XILINX_EDK to mean something different than you
>> are.
>> Perhaps it sould be instead:
>>
>> config XILINX_DRIVERS
>>         bool
>>         depends on XILINX_VIRTEX || XILINX_MICROBLAZE
>>         default y
> 
> Hmmm, yes.  XILINX_DRIVERS is probably better.
> 
>>
>> config XILINX_GPIO_EDK
>>         tristate "Xilinx EDK-based OPB GPIO Support"
>>         depends on XILINX_DRIVERS
>>         select XILINX_EDK
>>         help
>>         This option enables support for Xilinx GPIO using EDK OS
>> independent driver.
> 
> Why still have XILINX_EDK?  I thought you meant replace XILINX_EDK
> with XILINX_DRIVERS.
> 
> Cheers,
> g.
> 
