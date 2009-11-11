From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
Date: Wed, 11 Nov 2009 15:54:39 +0100
Message-ID: <4AFAD02F.9080305@mocean-labs.com>
References: <4AFACC6A.304@mocean-labs.com>
	<20091111144924.GG30489@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091111144924.GG30489@zod.rchland.ibm.com>
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

Josh Boyer wrote:
> On Wed, Nov 11, 2009 at 03:38:34PM +0100, Richard R=F6jfors wrote:
>> This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to i=
owrite(8|16|32)
>> and ioread(8|16|32). This to be able to build on platforms not supportin=
g the in/out calls
>> for instance x86.
>>
>> Support is also added for little endian writes. In some systems the regi=
sters should be
>> accessed little endian rather than big endian.
> =

> I wonder if you should make the endianness a config option.  Right now you
> have a conditional check for every read and write.  Does that impact
> performance at all?

It won't affect the performance noticeable.

In our case we need the possibility to run both endians using the same xili=
nx_spi module.

--Richard
