From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Date: Thu, 24 Jul 2014 13:42:10 +0200
Message-ID: <10365151.12bEvS9Gvj@wuerfel>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kweh Hock Leong <hock.leong.kweh@intel.com>,
 Eric Miao <eric.y.miao@gmail.com>, Chew Chiau Ee <chiau.ee.chew@intel.com>,
 Darren Hart <dvhart@linux.intel.com>, chiauee85@gmail.com,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Russell King <linux@arm.linux.org.uk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
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

On Thursday 24 July 2014 18:01:51 Kweh Hock Leong wrote:
> From: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
> 
> Intel LPSS Baytrail supports two DMA controllers and SPI is only
> using one of the DMA controller. During DMA channel request,
> we need to ensure the requested Tx and Rx channels are from the correct
> DMA controller. Thus, we add extra checking in filter callback funtion
> by matching against the DMA controller device name.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>

I'm confused. Doesn't  Bay Trail use ACPI to do the DMA
engine configuration? That should set find the right device/chan_id/slave_id
combination without any interaction, through the use of dma_request_slave_channel.

On a related note, there seems to be a bug in this driver, which
attempts to set the slave_id through dmaengine_slave_config(), which
is wrong in both cases, ACPI and filter functions.

	Arnd
