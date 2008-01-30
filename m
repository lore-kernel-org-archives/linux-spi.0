From: "zhang zhilong" <zhang.zhilong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: how to speed up the spi speed ?
Date: Wed, 30 Jan 2008 18:00:33 +0800
Message-ID: <f45effa60801300200t390936bdmefc8f5f5b8995669@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1824156984=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============1824156984==
Content-Type: multipart/alternative;
	boundary="----=_Part_579_32837065.1201687233228"

------=_Part_579_32837065.1201687233228
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,everyone.

i found the spi speed can't set like this:

void iodata_transfer(int fd,int len)
{
   ...
    struct spi_ioc_transfer xfer[1];
    memset(xfer,0,sizeof xfer);
    xfer[0].rx_buf=(__u64) buf;
    xfer[0].delay_usecs=0;
    xfer[0].len=len;
    xfer[0].speed_hz=12*1000*1000;//this will make error.

}
the max speed is 15000000hz;
how can i do?
thanks a lot;
-- 
zhang.zhilong

------=_Part_579_32837065.1201687233228
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi,everyone.</div>
<div>&nbsp;</div>
<div>i found the spi speed can&#39;t set like this:</div>
<div>&nbsp;</div>
<div>void iodata_transfer(int fd,int len)</div>
<div>{</div>
<div>&nbsp;&nbsp; ...</div>
<div>&nbsp;&nbsp;&nbsp; struct spi_ioc_transfer xfer[1];</div>
<div>&nbsp;&nbsp;&nbsp; memset(xfer,0,sizeof xfer);</div>
<div>&nbsp;&nbsp;&nbsp; xfer[0].rx_buf=(__u64) buf;</div>
<div>&nbsp;&nbsp;&nbsp; xfer[0].delay_usecs=0;</div>
<div>&nbsp;&nbsp;&nbsp; xfer[0].len=len;</div>
<div>&nbsp;&nbsp;&nbsp; xfer[0].speed_hz=12*1000*1000;//this will make error.</div>
<div>&nbsp;&nbsp;&nbsp; </div>
<div>}</div>
<div>the max speed is 15000000hz;<br clear="all">how can i do?</div>
<div>thanks a lot;<br>-- <br>zhang.zhilong </div>

------=_Part_579_32837065.1201687233228--


--===============1824156984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1824156984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1824156984==--
