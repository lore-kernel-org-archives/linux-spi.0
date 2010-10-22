From: Cyril Chemparathy <cyril@ti.com>
Subject: Re: [PATCH v3 01/12] misc: add driver for sequencer serial port
Date: Fri, 22 Oct 2010 15:03:38 -0400
Message-ID: <4CC1E00A.3010109@ti.com>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>	<1287694873-12904-2-git-send-email-cyril@ti.com>
	<20101022152024.65e8f181@lxorguk.ukuu.org.uk>
Reply-To: cyril@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "davinci-linux-open-source@linux.davincidsp.com"
	<davinci-linux-open-source@linux.davincidsp.com>,
	"dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>,
	sameo@linux.intel.com, "broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"rpurdie@rpsys.net" <rpurdie@rpsys.net>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101022152024.65e8f181@lxorguk.ukuu.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 10/22/2010 10:20 AM, Alan Cox wrote:
> On Thu, 21 Oct 2010 17:01:02 -0400
> Cyril Chemparathy <cyril@ti.com> wrote:
> 
>> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
>> device.  It has a built-in programmable execution engine that can be programmed
>> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
>>
>> This patch adds a driver for this controller device.  The driver does not
>> expose a user-land interface.  Protocol drivers built on top of this layer are
>> expected to remain in-kernel.
> 
> I suspect the driver belongs with the mfd drivers not with drivers/misc ?
> 
> otherwise it looks very nice.

Unlike MFDs, this device doesn't have cells with differing
functionality.  Instead it has functionally identical ports that can
operate in a variety of modes.  That said, does this still fit in with
other MFD drivers?  If so, I don't see a problem with moving it there.

Thanks
Cyril.
