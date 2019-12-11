From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH RFC 0/2] Add Renesas RPC-IF support
Date: Wed, 11 Dec 2019 19:20:51 +0300
Message-ID: <0af05149-78f5-8639-4a23-84edda0073ea@cogentembedded.com>
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

On 12/11/2019 05:33 PM, Chris Brandt wrote:

>> Here's a set of 2 patches against Linus' repo. Renesas Reduced Pin Count
>> Interface (RPC-IF) allows a SPI flash or HyperFlash connected to the SoC to
>> be accessed via the external address space read mode or the manual mode.
> 
> Looking at this driver, all it is are APIs. Meaning another driver is 
> needed to sit in between the MTD layer and this HW driver layer.
> 
> In the driver that I did, if the "RPC" HW is going to be used to control
> a SPI Flash device, it registered a spi controller and then the MTD 
> layer could access the device

   Via the SPI-to-MTD sublayer for (at least) direct mapping -- grep for "dirmap"
in drivers/mtd/spi-nor/spi-nor.c...

> just like any other SPI controller driver. No
> additional drivers are needed.

   Then why do we have *struct* spi_controller_mem_ops? Do All drivers implement
such ops?

[...]

MBR, Sergei
