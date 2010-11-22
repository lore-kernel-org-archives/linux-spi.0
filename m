From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH v6 08/12] gpio: add ti-ssp gpio driver
Date: Tue, 23 Nov 2010 08:35:58 +1300
Message-ID: <4CEAC61E.40504@bluewatersys.com>
References: <1290182156-20104-1-git-send-email-cyril@ti.com>
	<1290182156-20104-9-git-send-email-cyril@ti.com>
	<4CE97AE5.3040801@bluewatersys.com>
	<AANLkTikYu4H8aWOvK+q6g4YgUZxD_80UKBdr=eB__frF@mail.gmail.com>
	<20101122112038.GD16504@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source@linux.davincidsp.com,
	dbrownell@users.sourceforge.net, sameo@linux.intel.com,
	khilman@deeprootsystems.com, linus.ml.walleij@gmail.com,
	Grant Likely <grant.likely@secretlab.ca>, rpurdie@rpsys.net,
	alan@lxorguk.ukuu.org.uk, Cyril Chemparathy <cyril@ti.com>,
	spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	lrg@slimlogic.co.uk
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20101122112038.GD16504@rakim.wolfsonmicro.main>
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

On 11/23/2010 12:20 AM, Mark Brown wrote:
> On Sun, Nov 21, 2010 at 02:31:38PM -0700, Grant Likely wrote:
>> On Sun, Nov 21, 2010 at 1:02 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> 
>>> Currently the code will allow you to install
>>> several peripherals at once, which will lead to odd behaviour at
>>> runtime. Maybe a better approach would be to have something like this in
>>> drivers/mfd/ti-ssp.c:
> 
>> Only the ssp core itself is allowed to register the peripheral
>> devices, and so using the parent pointer is perfectly valid.  I think
>> Cyril's approach is fine.
> 
> This is very much a standard idiom for MFD children in Linux - if the
> children are entirely reliant on working through a parent-specific API
> anyway there's no issue with making the parent device be part of that
> API.

Yeah, I misunderstood how the registration worked. It is fine as is,
ignore my comments :-).

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
