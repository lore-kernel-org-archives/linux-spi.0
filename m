From: Stijn Devriendt <highguy@gmail.com>
Subject: Re: Linux 3.16: all my drivers on SPI bus report WARNING: at
 drivers/base/dd.c:286
Date: Thu, 28 Aug 2014 22:26:48 +0200
Message-ID: <CAOY=C6H=VwoQC7xPvKzsnY17Wd7UB=nrZ30SE-27+o9XqKDjpQ@mail.gmail.com>
References: <53F31707.4040300@c-s.fr>
	<53FF5097.7090000@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4034307968577114896=="
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-spi@vger.kernel.org,
 Axel Lin <axel.lin@ingics.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@linaro.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <53FF5097.7090000@c-s.fr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: linux-spi.vger.kernel.org

--===============4034307968577114896==
Content-Type: multipart/alternative; boundary=089e01227b862a55a20501b65bf7

--089e01227b862a55a20501b65bf7
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 28, 2014 at 5:53 PM, leroy christophe <christophe.leroy@c-s.fr>
wrote:

> I've been able to identify the origin of the issue. It happens since the
> below commit.
> Do you know what should be done to fix that ?
>
> Christophe
>

Actually, more things are wrong with what the driver is doing.
If inside spi_add_device() the call to device_add() fails, then that
code bails out without any call to spi_cleanup() and the same
memory will leak (Is this intended?).

Basically, fsl_spi_setup allocates memory using devm_kzalloc, while
device_add expects that any memory allocated via this way is only
done in the device's probe function.

The simple fix would be to do a normal allocation (revert the patch) and
add a free to the cleanup() function. Unfortunately that doesn't fix the
memleak I mentioned above.

So, some outside-the-box thinking brings me to conclude that another way
to fix this problem is to allocate the devm_kzalloc not on the device's
resource
list but on the controller's resources (it's controller state after all...).

Regards,
Stijn

--089e01227b862a55a20501b65bf7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Thu, Aug 28, 2014 at 5:53 PM, leroy christophe <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:christophe.leroy@c-s.fr" target=3D"_blank">christoph=
e.leroy@c-s.fr</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I&#39;ve been able to identify the origin of=
 the issue. It happens since the below commit.<br>
Do you know what should be done to fix that ?<br>
<br>
Christophe<br></blockquote><div><br></div><div>Actually, more things are wr=
ong with what the driver is doing.<br>If inside spi_add_device()  the call =
to device_add() fails, then that<br>code bails out without any call to spi_=
cleanup() and the same<br>
memory will leak (Is this intended?).<br><br></div><div>Basically, fsl_spi_=
setup allocates memory using devm_kzalloc, while<br></div><div>device_add e=
xpects that any memory allocated via this way is only<br>done in the device=
&#39;s probe function.<br>
<br></div><div>The simple fix would be to do a normal allocation (revert th=
e patch) and<br>add a free to the cleanup() function. Unfortunately that do=
esn&#39;t fix the<br>memleak I mentioned above.<br><br></div><div>So, some =
outside-the-box thinking brings me to conclude that another way<br>
to fix this problem is to allocate the devm_kzalloc not on the device&#39;s=
 resource<br>list but on the controller&#39;s resources (it&#39;s controlle=
r state after all...).<br></div><div><br></div><div>Regards,<br>Stijn<br>
</div></div></div></div>

--089e01227b862a55a20501b65bf7--

--===============4034307968577114896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============4034307968577114896==--
