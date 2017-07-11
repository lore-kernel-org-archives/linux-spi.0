From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Date: Tue, 11 Jul 2017 12:08:01 +0530
Message-ID: <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8@ti.com>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-mtd@lists.infradead.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
        <john@phrozen.org>, <linux-spi@vger.kernel.org>,
        <hauke.mehrtens@intel.com>, <andy.shevchenko@gmail.com>,
        <p.zabel@pengutronix.de>
To: Rob Herring <robh@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

Hi,

On Friday 07 July 2017 07:53 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>

I see you have added my name in cc but for some reason I don't have the patch
in my mailbox. Can you resend it please?

>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++

Please create a new directory withing phy for adding a phy driver.

Thanks
Kishon
