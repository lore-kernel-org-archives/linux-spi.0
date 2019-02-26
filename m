From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: Add dma-burst-sz property for
 spi-pxa2xx
Date: Tue, 26 Feb 2019 13:33:54 +0200
Message-ID: <20190226113354.GW9224@smile.fi.intel.com>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
 <20190226110238.GA7082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190226110238.GA7082@sirena.org.uk>
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

On Tue, Feb 26, 2019 at 11:02:38AM +0000, Mark Brown wrote:
> On Tue, Feb 26, 2019 at 12:24:39PM +0300, Andy Shevchenko wrote:
> > Add DMA burst size property to the SPI PXA2xx bindings.
> 
> Shouldn't we be inferring this from the device specific compatible
> string (or PCI identifier for x86)?  That way if there's other quirks
> needed we don't need any binding changes.

Hmm... Yes, we may use PCI ID for that.

-- 
With Best Regards,
Andy Shevchenko
