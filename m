From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC 0/2] Add Renesas RPC-IF support
Date: Wed, 11 Dec 2019 19:08:51 +0300
Message-ID: <03a630e2-280f-98b7-a9c8-6533716720e5@cogentembedded.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
 <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Yang <masonccyang@mxic.com.tw>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Chris Brandt <Chris.Brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR01MB156234F5B44BB43D3DCA98128A5A0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

HEllo

On 12/11/2019 05:33 PM, Chris Brandt wrote:

>> Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
>> Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC to
>> be accessed via the external address space read mode or the manual mode.
> 
> Looking at this driver, all it is are APIs. Meaning another driver is 
> needed to sit in between the MTD layer and this HW driver layer.

   Between the hardware and SPI, and between the hardware and HyperFlash
infrastructure. There's a lot of the common hardware code common between
these 2 driver areas.

> In the driver that I did, if the "RPC" HW is going to be used to control
> a SPI Flash device, it registered a spi controller and then the MTD 
> layer could access the device just like any other SPI controller driver. No
> additional drivers are needed.

   We're already been thru that with Mason's patch -- I don't want the code
duplicated between 2 drivers.

> Looking at the hyperbus driver that is in drivers/mtd/hyperbus/, it 
> seems that if the "RPC" HW is going to be used to control HyperFlash, then 

   Sure. But the code controlling RPC hardware is largely the same b/w 2 cases.

> all you would need to do is register a hyperbus controller using 
> hyperbus_register_device(). Then the MTD layer could read/write the flash using 
> normal MTD CFI interface.

   That's what I do (the current realization makes too many assumptions about
the HF hardware (both direct read and write). 

> Why do you think you need another layer in between the HW driver and the
> MTD layer?

   Because we don't want any duplicated code. Also, think about DT -- it
describes the hardware, not the driver configuration.

> Is your goal to make a multi-layered system where the HW jumps back and forth
> in between operating modes at runtime? I'm not sure of the use case for all of
> this.

   My goal is to prevent the code duplication (and keep DT sane too).

> Chris

MBR, Sergei
