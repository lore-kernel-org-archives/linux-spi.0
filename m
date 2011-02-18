From: LEROY Christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: MPC866, Help, SPI blocked at startup
Date: Fri, 18 Feb 2011 16:26:31 +0100
Message-ID: <4D5E8FA7.3080307@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	LinuxPPC-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

Sometimes (but rather often) I get SPI tasks hanging.

I get the following trace, as if both tasks where blocking each other, 
or they are waiting for a third task ?

Can someone help or tell what I should look at ?

[ 240.939898] INFO: task ff000a80.spi:197 blocked for more than 120 seconds.
[ 240.946495] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 240.954416] ff000a80.spi D 00000000 0 197 2 0x00000000
[ 240.960474] Call Trace:
[ 240.962816] [c1961d20] [c009cd80] d_free+0x68/0x7c (unreliable)
[ 240.968668] [c1961de0] [c00076fc] __switch_to+0x54/0x70
[ 240.974175] [c1961df0] [c0235c8c] schedule+0x42c/0x4d4
[ 240.979058] [c1961e40] [c0235fb8] schedule_timeout+0x30/0x1cc
[ 240.984759] [c1961e80] [c0235714] wait_for_common+0xe0/0x18c
[ 240.990392] [c1961ec0] [c017a480] mpc8xxx_spi_bufs+0x3d0/0x4c8
[ 240.996365] [c1961ee0] [c017a6a8] mpc8xxx_spi_work+0x130/0x290
[ 241.001987] [c1961f50] [c0035240] worker_thread+0x14c/0x200
[ 241.007713] [c1961fb0] [c003960c] kthread+0x7c/0x80
[ 241.012755] [c1961ff0] [c000e660] kernel_thread+0x4c/0x68
[ 241.017947] INFO: task firmware/mcr300:244 blocked for more than 120 
seconds.
[ 241.025131] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 241.032846] firmware/mcr3 D 00000000 0 244 2 0x00000000
[ 241.038833] Call Trace:
[ 241.041462] [c198fd90] [0000000f] 0xf (unreliable)
[ 241.046043] [c198fe50] [c00076fc] __switch_to+0x54/0x70
[ 241.051198] [c198fe60] [c0235c8c] schedule+0x42c/0x4d4
[ 241.056253] [c198feb0] [c0235fb8] schedule_timeout+0x30/0x1cc
[ 241.061957] [c198fef0] [c0235714] wait_for_common+0xe0/0x18c
[ 241.067797] [c198ff30] [c0178f7c] spi_sync+0x8c/0xb4
[ 241.072586] [c198ff70] [c0185704] fpga_fw_load+0x15c/0x3b8
[ 241.077968] [c198ff90] [c015da9c] request_firmware_work_func+0x58/0x84
[ 241.084434] [c198ffb0] [c003960c] kthread+0x7c/0x80
[ 241.089228] [c198fff0] [c000e660] kernel_thread+0x4c/0x68

Regards
C. Leroy


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
