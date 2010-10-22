From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH v4 5/5] mtd: m25p80: add support to parse the partitions
	by OF node
Date: Fri, 22 Oct 2010 01:01:12 -0500
Message-ID: <3AE1F37D-F328-40EF-8B35-F94CC074D384@freescale.com>
References: <1286878714-13090-1-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-2-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-3-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-4-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-5-git-send-email-Mingkai.hu@freescale.com>
	<1286878714-13090-6-git-send-email-Mingkai.hu@freescale.com>
	<1287256647.1781.34.camel@brekeke>
	<AANLkTimr03KAKnz5sfwm19=KzB-ik95WM_qQO0YP9qVs@mail.gmail.com>
	<1287301490.1951.0.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dedekind1@gmail.com, David Brownell <david-b@pacbell.net>,
	Linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1287301490.1951.0.camel@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org


On Oct 17, 2010, at 2:44 AM, Artem Bityutskiy wrote:

> On Sat, 2010-10-16 at 19:05 -0600, Grant Likely wrote:
>> On Sat, Oct 16, 2010 at 1:17 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
>>> On Tue, 2010-10-12 at 18:18 +0800, Mingkai Hu wrote:
>>>> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>>>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>>>> ---
>>>> v4:
>>>> - Updated to latest kernel base(Linux 2.6.36-rc7).
>>>> - Made changes according to Grant's comments.
>>> 
>>> Looks good to me, pushed to l2-mtd-2.6.git, thanks.
>> 
>> Wait!  It will break whenever CONFIG_OF is not set.  I broke
>> linux-next with this patch.  It can be solved by wrapping the block
>> with #ifdef CONFIG_OF, but I'd like to find a better solution.
> 
> OK, removed.

Grant, poke.  Would like to see this either resolved or have this patch go in for .37 w/CONFIG_OF and fix properly for .38.

- k
