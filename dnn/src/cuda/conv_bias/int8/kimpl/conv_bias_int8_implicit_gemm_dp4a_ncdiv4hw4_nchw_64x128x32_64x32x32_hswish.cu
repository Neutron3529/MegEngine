#if !MEGDNN_TEGRA_X1
// generated by gen_cuda_conv_bias_kern_impls.py
// ignore warning of cutlass
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wstrict-aliasing"
#include "src/cuda/conv_bias/int8/conv_bias_int8_implicit_gemm_cutlass_wrapper.cuinl"

using LayoutSrc = cutlass::layout::TensorNCxHWx<4>;
using LayoutFilter = cutlass::layout::TensorCxRSKx<4>;
using LayoutDst = cutlass::layout::TensorNCHW;
using ThreadBlockShape = cutlass::gemm::GemmShape<64, 128, 32>;
using WarpShape = cutlass::gemm::GemmShape<64, 32, 32>;
using InstructionShape = cutlass::gemm::GemmShape<1, 1, 4>;
using EpilogueOp = cutlass::epilogue::thread::BiasAddLinearCombinationHSwish<
                    float, 1, int32_t, float, float>;
using Convolution = cutlass::convolution::device::Convolution<
    int8_t, LayoutSrc, int8_t, LayoutFilter, float, 
    LayoutDst, float, LayoutDst, int32_t, 
    cutlass::convolution::ConvType::kConvolution, cutlass::arch::OpClassSimt, cutlass::arch::Sm61, 
    ThreadBlockShape, WarpShape, InstructionShape, EpilogueOp, 
    cutlass::convolution::threadblock::ConvolutionNCxHWxThreadblockSwizzle<
    cutlass::convolution::ConvType::kConvolution>, 
    2, 4, 16, true, 
    cutlass::arch::OpMultiplyAdd>;
template void megdnn::cuda::cutlass_wrapper::cutlass_convolution_wrapper<Convolution>(
        const typename Convolution::ElementSrc* d_src, 
        const typename Convolution::ElementFilter* d_filter, 
        const typename Convolution::ElementBias* d_bias, 
        const typename Convolution::ElementDst* d_z, 
        typename Convolution::ElementDst* d_dst, 
        int* workspace, 
        typename Convolution::ConvolutionParameter const& conv_param, 
        typename Convolution::EpilogueOutputOp::Params const& epilogue, 
        cudaStream_t stream);
#pragma GCC diagnostic pop
#endif
