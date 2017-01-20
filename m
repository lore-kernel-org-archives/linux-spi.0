From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
Date: Fri, 20 Jan 2017 08:42:11 +0100
Message-ID: <87inpadvos.fsf@belgarion.home>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
 <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Sascha Weisenberger <sascha.weisenberger@siemens.com>,
 Daniel Mack <daniel@zonque.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com> (Jan Kiszka's
 message of "Thu, 19 Jan 2017 20:37:40 +0100")
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

Jan Kiszka <jan.kiszka@siemens.com> writes:

> When using the a device with edge-triggered interrupts, such as MSIs,
> the interrupt handler has to ensure that there is a point in time during
> its execution where all interrupts sources are silent so that a new
> event can trigger a new interrupt again.
>
> This is achieved here by disabling all interrupt sources for a moment
> before processing them according to the status register. If a new
> interrupt should have arrived after we read the status, it will now
> re-trigger the interrupt, even in edge mode.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
