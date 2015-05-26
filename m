From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 1/3] spi: orion: Fix maximum baud rates for Armada 370/XP
Date: Tue, 26 May 2015 14:08:43 +0200
Message-ID: <5564624B.1030503@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
 <20150526103650.GM21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Tawfik Bayouk <tawfik@marvell.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-spi@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150526103650.GM21577@sirena.org.uk>
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

Hi Mark,

On 26/05/2015 12:36, Mark Brown wrote:
> On Tue, May 26, 2015 at 11:44:42AM +0200, Gregory CLEMENT wrote:
> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Reported-by: Kostya Porotchkin <kostap@marvell.com>
>> Cc: <stable@vger.kernel.org> #Fixes df59fa7f4bca
> 
> Applied, but please format this stuff in a standard fashion - use a
> Fixes: tag to reference commits you're fixing.  This makes it easier for
> tooling to work with the information you're providing.

Yes, sure, I will do. I followed the Documentation/stable_kernel_rules.txt
file and I missed the new information in Documentation/SubmittingPatches
about this tag.

Thanks,

Gregory




-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
