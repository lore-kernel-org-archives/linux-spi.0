From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
Date: Fri, 19 Jun 2009 13:45:46 +0200
Message-ID: <c384c5ea0906190445u130a4fedv14c22c7f9abdb9d8@mail.gmail.com>
References: <4A39DC80.7030906@arvoo.nl>
	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, Rini van Zetten <rini@arvoo.nl>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
To: Kumar Gala <galak@kernel.crashing.org>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
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

Hello,

On Thu, Jun 18, 2009 at 4:04 PM, Kumar Gala<galak@kernel.crashing.org> wrot=
e:
> On Jun 18, 2009, at 8:09 AM, Anton Vorontsov wrote:
>> On Thu, Jun 18, 2009 at 08:19:44AM +0200, Rini van Zetten wrote:
>>>
>>> This patch adds the possibility to have a spi device without a cs.
>>>
> That is a good question. =A0What HW is this for (I don't think its for eS=
PI
> but I could be wrong).
>
We need SPI without CS too on our MPC8313E design.

In our case having a CS line to each slave (18 of them) is too
expensive and we use a chip select which piggy backs on another
signal.
Once the slave is selected, SPI is used to send large amounts of data.

Regards,
-- =

Leon
