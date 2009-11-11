From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
Date: Wed, 11 Nov 2009 14:09:23 -0700
Message-ID: <fa686aa40911111309k4492688xe6aed848bb3ad05c@mail.gmail.com>
References: <4AFACC6A.304@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <4AFACC6A.304@mocean-labs.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 11, 2009 at 7:38 AM, Richard R=F6jfors
<richard.rojfors@mocean-labs.com> wrote:
> This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to io=
write(8|16|32)
> and ioread(8|16|32). This to be able to build on platforms not supporting=
 the in/out calls
> for instance x86.

As discussed previously, I'd rather see as an ops table instead of as
if/else in each accessor, but I won't push it unless I hear the same
opinion from others.  John what do you think?  (But if it should be an
ops table, then I want it done now so that we don't end up with
another just as invasive patch to change the form yet again in 6
months time).

Otherwise looks good to me on brief read-through.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
